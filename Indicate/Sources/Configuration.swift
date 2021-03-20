//
//  Configuration.swift
//  Indicate
//
//  Created by Philip Kluz on 2021-03-07.
//  Copyright © 2021 Philip Kluz. All rights reserved.
//

import UIKit

// MARK: Indicate > Content

extension Indicate {
    
    /// Configuration structure controlling various aspects of the `Indicate` indicator.
    public struct Configuration {
        
        public typealias Action = (PresentationController) -> Void
        
        // MARK: Configuration (Public Properties)
        
        /// Handler invoked whenever the user taps on the indicator.
        public let tap: Action?
        
        /// Handler invoked whenever the indicator appears on-screen.
        public let appeared: Action?
        
        /// Handler invoked whenever the indicator disappears off-screen.
        public let dismissed: Action?
        
        /// Duration to show the indicator for before automatically dismissing it. *NOTE:* Interaction with the indicator resets the timer.
        public let duration: TimeInterval
        
        /// Size of the indicator (excluding shadows).
        public let size: CGSize
        
        /// Padding to apply around the content area inside the indicator.
        public let contentPadding: UIEdgeInsets
        
        /// Spacing between various items inside the content area of the indicator (e.g. image view and text area).
        public let horizontalItemSpacing: CGFloat
        
        /// Default configuration.
        public static let `default`: Configuration = Configuration()
        
        // MARK: Configuration (Private Static  Properties)
        
        private static let defaultSize: CGSize = CGSize(width: 215.0, height: 50.0)
        
        private static let defaultDuration: TimeInterval = 3.0
        
        private static let defaultContentPadding: UIEdgeInsets = UIEdgeInsets(top: 8.0, left: 16.0, bottom: 8.0, right: 16.0)
        
        private static let defaultHorizontalItemSpacing: CGFloat = 8.0
        
        // MARK: Configuration (Public Methods)
        
        /// Instantiate a new `Configuration` structure.
        ///
        /// - Parameters:
        ///   - tap: Handler invoked whenever the user taps on the indicator.
        ///   - appeared: Handler invoked whenever the indicator appears on-screen.
        ///   - dismissed: Handler invoked whenever the indicator disappears off-screen.
        ///   - duration: Duration to show the indicator for before automatically dismissing it. *NOTE:* Interaction with the indicator resets the timer.
        ///   - size: Size of the indicator (excluding shadows).
        ///   - contentPadding: Padding to apply around the content area inside the indicator.
        ///   - horizontalItemSpacing: Spacing between various items inside the content area of the indicator (e.g. image view and text area).
        public init(tap: Action? = nil, appeared: Action? = nil, dismissed: Action? = nil, duration: TimeInterval? = nil, size: CGSize? = nil, contentPadding: UIEdgeInsets? = nil, horizontalItemSpacing: CGFloat? = nil) {
            self.tap = tap
            self.appeared = appeared
            self.dismissed = dismissed
            self.duration = duration ?? Self.defaultDuration
            self.contentPadding = contentPadding ?? Self.defaultContentPadding
            self.size = size ?? Self.defaultSize
            self.horizontalItemSpacing = horizontalItemSpacing ?? Self.defaultHorizontalItemSpacing
        }
    }
}

// MARK: Indicate.Configuration > Withs

extension Indicate.Configuration {
    
    /// Create a copy of the current configuration structure with a new `tap` handler.
    public func with(tap: Action?) -> Self {
        return Indicate.Configuration(tap: tap, appeared: appeared, dismissed: dismissed, duration: duration, size: size, contentPadding: contentPadding, horizontalItemSpacing: horizontalItemSpacing)
    }
    
    /// Create a copy of the current configuration structure with a new `appeared` handler.
    public func with(appeared: Action?) -> Self {
        return Indicate.Configuration(tap: tap, appeared: appeared, dismissed: dismissed, duration: duration, size: size, contentPadding: contentPadding, horizontalItemSpacing: horizontalItemSpacing)
    }
    
    /// Create a copy of the current configuration structure with a new `dismissed` handler.
    public func with(dismissed: Action?) -> Self {
        return Indicate.Configuration(tap: tap, appeared: appeared, dismissed: dismissed, duration: duration, size: size, contentPadding: contentPadding, horizontalItemSpacing: horizontalItemSpacing)
    }
    
    /// Create a copy of the current configuration structure with a new `duration` value.
    public func with(duration: TimeInterval) -> Self {
        return Indicate.Configuration(tap: tap, appeared: appeared, dismissed: dismissed, duration: duration, size: size, contentPadding: contentPadding, horizontalItemSpacing: horizontalItemSpacing)
    }
    
    /// Create a copy of the current configuration structure with a new `size` value.
    public func with(size: CGSize) -> Self {
        return Indicate.Configuration(tap: tap, appeared: appeared, dismissed: dismissed, duration: duration, size: size, contentPadding: contentPadding, horizontalItemSpacing: horizontalItemSpacing)
    }
    
    /// Create a copy of the current configuration structure with a new `contentPadding` value.
    public func with(contentPadding: UIEdgeInsets) -> Self {
        return Indicate.Configuration(tap: tap, appeared: appeared, dismissed: dismissed, duration: duration, size: size, contentPadding: contentPadding, horizontalItemSpacing: horizontalItemSpacing)
    }
    
    /// Create a copy of the current configuration structure with a new `horizontalItemSpacing` value.
    public func with(horizontalItemSpacing: CGFloat) -> Self {
        return Indicate.Configuration(tap: tap, appeared: appeared, dismissed: dismissed, duration: duration, size: size, contentPadding: contentPadding, horizontalItemSpacing: horizontalItemSpacing)
    }
}
