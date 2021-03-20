//
//  PresentationController.swift
//  Indicate
//
//  Created by Philip Kluz on 2021-03-07.
//  Copyright © 2021 Philip Kluz. All rights reserved.
//

import UIKit

extension Indicate {
    
    /// Internal storage of presentation controllers to avoid deallocation in case the user does not retain a strong reference to the controller themselves.
    fileprivate static var activePresentationControllers: [UUID: PresentationController] = [:]
    
    /// This object manages the presentation of an `Indicate` view. It takes care of the entire lifecycle, gesture handling, and animations.
    public final class PresentationController: NSObject {
        
        // MARK: PresentationController (Private Types)
        
        private enum AnimatorType {
            case show
            case dismiss
        }
        
        // MARK: PresentationController (Private Properties)
        
        private let id: UUID = UUID()
        
        private let indicator: View
        
        private var animators: [AnimatorType: UIViewPropertyAnimator] = [:]
        
        private lazy var tapGestureRecognizer: UITapGestureRecognizer = {
            let recognizer = UITapGestureRecognizer(target: self, action: #selector(recognizedTap(_:)))
            return recognizer
        }()
        
        private lazy var panGestureRecognizer: UIPanGestureRecognizer = {
            let recognizer = UIPanGestureRecognizer(target: self, action: #selector(recognizedPan(_:)))
            return recognizer
        }()
        
        private var panOrigin: CGPoint = .zero
        
        private var dismissTimer: Timer?
        
        // MARK: PresentationController (Public Properties)
        
        /// Contents to be presented.
        public private(set) var content: Content
        
        /// The presentation controller's underlying configuration.
        public let configuration: Configuration
        
        // MARK: PresentationController (Public Methods)
        
        /// Instantiate a new `PresentationController` to manage the lifecycle of an `Indicate` indicator.
        ///
        /// - Parameters:
        ///   - content: Content to present inside of the `Indicate` indicator.
        ///   - configuration: Configuration controlling various aspects of the presentation like interaction and sizing.
        public init(content inContent: Content, configuration inConfiguration: Configuration = .default) {
            content = inContent
            configuration = inConfiguration
            indicator = View(viewModel: ViewModel(content: content,
                                                  size: configuration.size,
                                                  contentPadding: configuration.contentPadding,
                                                  horizontalItemSpacing: configuration.horizontalItemSpacing))
            
            super.init()
            
            indicator.addGestureRecognizer(tapGestureRecognizer)
            indicator.addGestureRecognizer(panGestureRecognizer)
            
            if #available(iOS 13.4, *) {
                enablePointerInteraction()
            }
        }
        
        /// Present an indicator on the given `view`.
        ///
        /// - Parameter view: View to present the indicator ontop of.
        @objc
        public func present(in view: UIView) {
            guard Indicate.activePresentationControllers[id] == nil else { return }
            Indicate.activePresentationControllers[id] = self
            
            view.addSubview(indicator)
            
            indicator.sizeToFit()
            indicator.isUserInteractionEnabled = true
            
            let offScreenPosition = self.offScreenPosition(forIndicator: indicator)
            let onScreenPosition = self.onScreenPosition(forIndicator: indicator)
            
            indicator.center = offScreenPosition
            
            animators[.show] = { (view: UIView, rescheduleDismissTimer: @escaping () -> Void, completion: @escaping (UIViewAnimatingPosition) -> Void) -> UIViewPropertyAnimator in
                let animator = UIViewPropertyAnimator(duration: 0.4, curve: .easeInOut)
                
                animator.addAnimations {
                    view.center = onScreenPosition
                }
                
                animator.addCompletion { position in
                    if position == .end {
                        rescheduleDismissTimer()
                    }
                }
                
                animator.addCompletion(completion)
                
                return animator
            }(indicator, rescheduleDismissTimer, finalizeAppear)
            
            animators[.show]?.startAnimation()
        }
        
        /// Dismiss the indicator.
        /// - Parameter sender: Arbitrary object triggering the dismissal. **Optional**
        @objc
        public func dismiss(_ sender: Any? = nil) {
            invalidateDismissTimerIfNeeded()
            
            indicator.sizeToFit()
            
            let offScreenPosition = self.offScreenPosition(forIndicator: indicator)
            let onScreenPosition = self.onScreenPosition(forIndicator: indicator)
            
            indicator.center = onScreenPosition
            indicator.isUserInteractionEnabled = false
            
            animators[.dismiss] = { (view: UIView, completion: @escaping (UIViewAnimatingPosition) -> Void) -> UIViewPropertyAnimator in
                let animator = UIViewPropertyAnimator(duration: 0.4, curve: .easeInOut)
                
                animator.addAnimations {
                    view.center = offScreenPosition
                }
                
                animator.addCompletion(completion)
                
                return animator
            }(indicator, finalizeDismiss)
            
            animators[.dismiss]?.startAnimation()
        }
        
        // MARK: Presentation Controller (Private Methods)
        
        private func onScreenPosition(forIndicator indicator: View) -> CGPoint {
            return CGPoint(x: indicator.superview?.center.x ?? indicator.center.x, y: indicator.bounds.height * 1.5)
        }
        
        private func offScreenPosition(forIndicator indicator: View) -> CGPoint {
            return CGPoint(x: indicator.superview?.center.x ?? indicator.center.x, y: -indicator.bounds.height * 1.5)
        }
        
        @objc
        private func recognizedTap(_ recognizer: UITapGestureRecognizer) {
            configuration.tap?(self)
        }
        
        @objc
        private func recognizedPan(_ recognizer: UIPanGestureRecognizer) {
            let currentPanPosition = recognizer.location(in: indicator.superview)
            
            switch recognizer.state {
            case .began:
                invalidateDismissTimerIfNeeded()
                panOrigin = currentPanPosition
            case .changed:
                let onScreenPosition = self.onScreenPosition(forIndicator: indicator)
                let absoluteVerticalChange = currentPanPosition.y - panOrigin.y
                
                func ease(x inx: CGFloat) -> CGFloat {
                    let x = max(-2.0, min(2.0, inx))
                    return sin(x * CGFloat(Float.pi) / 4.0)
                }
                
                func progress(value: CGFloat, min: CGFloat, max: CGFloat) -> CGFloat {
                    let x: CGFloat = value
                    let a: CGFloat = min
                    let b: CGFloat = max
                    let c: CGFloat = 0.0
                    let d: CGFloat = 1.0
                    
                    return (x - a) / (b - a) * (d - c) + c
                }
                
                let p = progress(value: absoluteVerticalChange, min: 0.0, max: 50.0)
                let e = ease(x: p)
                
                indicator.center = CGPoint(x: indicator.center.x, y: onScreenPosition.y + (onScreenPosition.y * e))
            case .ended, .cancelled, .failed:
                let absoluteVerticalChange = currentPanPosition.y - panOrigin.y
                panOrigin = .zero
                
                if absoluteVerticalChange < 0.0 {
                    snapHidden(animated: true, completion: { [weak self] success in
                        self?.finalizeDismiss(.end)
                    })
                } else {
                    rescheduleDismissTimer()
                    snapVisible(animated: true)
                }
            default:
                break
            }
        }
        
        private func invalidateDismissTimerIfNeeded() {
            dismissTimer?.invalidate()
            dismissTimer = nil
        }
        
        private func rescheduleDismissTimer() {
            dismissTimer?.invalidate()
            dismissTimer = nil
            
            let timer = Timer(timeInterval: configuration.duration,
                              target: self,
                              selector: #selector(dismiss(_:)),
                              userInfo: nil,
                              repeats: false)
            dismissTimer = timer
            RunLoop.main.add(timer, forMode: .common)
        }
        
        @objc
        private func snapHidden(animated: Bool, completion: @escaping (Bool) -> Void = { _ in }) {
            snap(to: offScreenPosition(forIndicator: indicator), animated: animated, completion: { [weak self] success in
                completion(success)
                self?.rescheduleDismissTimer()
            })
        }
        
        @objc
        private func snapVisible(animated: Bool, completion: @escaping (Bool) -> Void = { _ in }) {
            snap(to: onScreenPosition(forIndicator: indicator), animated: animated, completion: { [weak self] success in
                 completion(success)
                 self?.rescheduleDismissTimer()
            })
        }
        
        @objc
        private func snap(to: CGPoint, animated: Bool, completion: @escaping (Bool) -> Void = { _ in }) {
            if animated {
                UIView.animate(withDuration: 0.4,
                               delay: 0.0,
                               usingSpringWithDamping: 0.6,
                               initialSpringVelocity: 0.3,
                               options: .beginFromCurrentState,
                               animations: {
                                   self.indicator.center = to
                               }, completion: completion)
            } else {
                indicator.center = to
            }
        }
        
        @objc
        private func finalizeAppear(_ position: UIViewAnimatingPosition) {
            guard position == .end else { return }
            configuration.appeared?(self)
        }
        
        @objc
        private func finalizeDismiss(_ position: UIViewAnimatingPosition) {
            guard position == .end else { return }
            
            configuration.dismissed?(self)
            
            invalidateDismissTimerIfNeeded()
            animators.removeAll()
            
            indicator.removeGestureRecognizer(tapGestureRecognizer)
            indicator.removeGestureRecognizer(panGestureRecognizer)
            indicator.removeFromSuperview()
            
            Indicate.activePresentationControllers[id] = nil
        }
    }
}

// MARK: - UIPointerInteractionDelegate

@available(iOS 13.4, *)
extension Indicate.PresentationController: UIPointerInteractionDelegate {
    
    internal func enablePointerInteraction() {
        indicator.addInteraction(UIPointerInteraction(delegate: self))
    }
    
    public func pointerInteraction(_ interaction: UIPointerInteraction, regionFor request: UIPointerRegionRequest, defaultRegion: UIPointerRegion) -> UIPointerRegion? {
        return defaultRegion
    }
    
    public func pointerInteraction(_ interaction: UIPointerInteraction, styleFor region: UIPointerRegion) -> UIPointerStyle? {
        return UIPointerStyle(effect: .lift(UITargetedPreview(view: indicator)))
    }
    
    public func pointerInteraction(_ interaction: UIPointerInteraction, willEnter region: UIPointerRegion, animator: UIPointerInteractionAnimating) {
        invalidateDismissTimerIfNeeded()
    }
    
    public func pointerInteraction(_ interaction: UIPointerInteraction, willExit region: UIPointerRegion, animator: UIPointerInteractionAnimating) {
        rescheduleDismissTimer()
    }
}
