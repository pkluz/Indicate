//
//  MainViewController.swift
//  Indicate Example
//
//  Created by Philip Kluz on 2021-03-07.
//  Copyright © 2021 Philip Kluz. All rights reserved.
//

import UIKit
import Indicate

// MARK: - MainViewController

public class MainViewController: UIViewController {
    
    // MARK: UIViewController
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(buttonStackView)
        view.backgroundColor = UIColor(named: "BackgroundColor")
        
        buttonStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        buttonStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        buttonStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75).isActive = true
    }

    // MARK: MainViewController (Private Properties)

    public var indicatePresentationController: Indicate.PresentationController?
    
    public lazy var buttons: [UIButton] = {
        return [
            button(title: "Image + Left Aligned", target: self, action: #selector(presentIndicatorWithLeftAlignmentAndImage(_:))),
            button(title: "Image + Right Aligned", target: self, action: #selector(presentIndicatorWithRightAlignmentAndImage(_:))),
            button(title: "Emoji + Left Aligned", target: self, action: #selector(presentIndicatorWithLeftAlignmentAndEmoji(_:))),
            button(title: "Emoji + Right Aligned", target: self, action: #selector(presentIndicatorWithRightAlignmentAndEmoji(_:))),
            button(title: "No Image + Center Aligned", target: self, action: #selector(presentIndicatorWithCenterAlignment(_:))),
            button(title: "No Image + Left Aligned", target: self, action: #selector(presentIndicatorWithLeftAlignment(_:))),
            button(title: "No Image + Right Aligned", target: self, action: #selector(presentIndicatorWithRightAlignment(_:)))
        ]
    }()
    
    public lazy var buttonStackView: UIStackView = {
        let view = UIStackView()
        view.distribution = .equalSpacing
        view.axis = .vertical
        view.translatesAutoresizingMaskIntoConstraints = false
        view.spacing = 8.0
        for button in buttons {
            view.addArrangedSubview(button)
        }
        
        return view
    }()

    // MARK: MainViewController (Public Methods)
    
    @objc
    public func presentIndicatorWithRightAlignmentAndImage(_ sender: Any) {
        present(alignment: .right,
                attachment: .image(.init(value: UIImage(named: "m",
                                                        in: Bundle(for: Self.self),
                                                        compatibleWith: traitCollection),
                                         alignment: .right)))
    }
    
    @objc
    public func presentIndicatorWithLeftAlignmentAndImage(_ sender: Any) {
        present(alignment: .left,
                attachment: .image(.init(value: UIImage(named: "m",
                                                        in: Bundle(for: Self.self),
                                                        compatibleWith: traitCollection),
                                         alignment: .left)))
    }
    
    @objc
    public func presentIndicatorWithRightAlignmentAndEmoji(_ sender: Any) {
        present(alignment: .right, attachment: .emoji(.init(value: "🌼", alignment: .right)))
    }
    
    @objc
    public func presentIndicatorWithLeftAlignmentAndEmoji(_ sender: Any) {
        present(alignment: .left, attachment: .emoji(.init(value: "🌼", alignment: .left)))
    }
    
    @objc
    public func presentIndicatorWithRightAlignment(_ sender: Any) {
        present(alignment: .right, attachment: nil)
    }
    
    @objc
    public func presentIndicatorWithLeftAlignment(_ sender: Any) {
        present(alignment: .left, attachment: nil)
    }
    
    @objc
    public func presentIndicatorWithCenterAlignment(_ sender: Any) {
        present(alignment: .center, attachment: nil)
    }
    
    // MARK: MainViewController (Private Methods)
    
    @objc
    private func indicatorTapped(_ controller: Indicate.PresentationController) {
        controller.dismiss(self)
    }
    
    @objc
    private func indicatorAppeared(_ controller: Indicate.PresentationController) {
        print("appeared: \(controller)")
    }
    
    @objc
    private func indicatorDismissed(_ controller: Indicate.PresentationController) {
        print("appeared: \(controller)")
    }
    
    private func present(alignment: NSTextAlignment, attachment: Indicate.Content.Attachment?) {
        let title: String = {
            switch alignment {
            case .left:
                return "Left"
            case .natural:
                return "System"
            case .right:
                return "Right"
            case .center:
                return "Center"
            default:
                return "Other"
            }
        }() + " Aligned"
        
        let subtitle: String = {
            switch attachment {
            case .none:
                return "Without Attachment"
            case .emoji(let emoji):
                if emoji.value != nil {
                    return "With Emoji"
                }

                return "No Emoji"
            case .image(let image):
                if image.value != nil {
                    return "With Image"
                }

                return "No Image"
            }
        }()
        
        let content = Indicate.Content(title: .init(value: title, alignment: alignment),
                                       subtitle: .init(value: subtitle, alignment: alignment),
                                       attachment: attachment)
        
        let configuration = Indicate.Configuration(tap: indicatorTapped, appeared: indicatorAppeared, dismissed: indicatorDismissed)
        
        indicatePresentationController = Indicate.PresentationController(content: content, configuration: configuration)
        indicatePresentationController?.present(in: view)
    }
    
    private func button(title: String, target: Any, action: Selector) -> UIButton {
        let attributedTitle: NSAttributedString = {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            paragraphStyle.lineBreakMode = .byTruncatingTail
            
            let attributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.white,
                .font: UIFont.boldSystemFont(ofSize: 13.0),
                .paragraphStyle: paragraphStyle
            ]
            
            return NSAttributedString(string: title, attributes: attributes)
        }()
        
        let button = UIButton()
        button.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(target, action: action, for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1.0)
        button.layer.cornerRadius = 25.0
        if #available(iOS 13.0, *) {
            button.layer.cornerCurve = .continuous
        }
        return button
    }
}
