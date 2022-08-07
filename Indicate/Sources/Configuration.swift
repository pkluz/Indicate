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
        
        public enum ContentSizingMode {
            case intrinsic
            case custom(CGSize)
        }
        
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
        public let contentSizingMode: ContentSizingMode
        
        /// Padding to apply around the content area inside the indicator.
        public let contentPadding: UIEdgeInsets
        
        /// Spacing between various items inside the content area of the indicator (e.g. image view and text area).
        public let horizontalItemSpacing: CGFloat
        
        /// Indicator's title color
        public let titleColor: UIColor
        
        /// Indicator's subtitle color
        public let subtitleColor: UIColor
        
        /// Indicator's background color
        public let backgroundColor: UIColor
        
        /// Indicator's title font
        public let titleFont: UIFont
        
        /// Indicator's subtitle font
        public let subtitleFont: UIFont
        
        /// Default configuration.
        public static let `default`: Configuration = Configuration()
        
        // MARK: Configuration (Private Static  Properties)
        
        private static let defaultSize: CGSize = CGSize(width: 215.0, height: 50.0)
        
        private static let defaultDuration: TimeInterval = 3.0
        
        private static let defaultContentPadding: UIEdgeInsets = UIEdgeInsets(top: 8.0, left: 16.0, bottom: 8.0, right: 16.0)
        
        private static let defaultHorizontalItemSpacing: CGFloat = 8.0
        
        private static let defaultTitleColor: UIColor = UIColor(named: "TitleColor", in: .indicate, compatibleWith: nil) ?? UIColor.black
        
        private static let defaultSubtitleColor: UIColor = UIColor(named: "SubtitleColor", in: .indicate, compatibleWith: nil) ?? UIColor.darkGray
        
        private static let defaultBackgroundColor: UIColor = UIColor(named: "BackgroundColor", in: .indicate, compatibleWith: nil) ?? UIColor.white
        
        private static let defaultTitleFont: UIFont = UIFont.boldSystemFont(ofSize: 13.0)
        
        private static let defaultSubtitleFont: UIFont = UIFont.boldSystemFont(ofSize: 13.0)
        
        // MARK: Configuration (Public Methods)
        
        /// Instantiate a new `Configuration` structure.
        ///
        /// - Parameters:
        ///   - tap: Handler invoked whenever the user taps on the indicator.
        ///   - appeared: Handler invoked whenever the indicator appears on-screen.
        ///   - dismissed: Handler invoked whenever the indicator disappears off-screen.
        ///   - duration: Duration to show the indicator for before automatically dismissing it. *NOTE:* Interaction with the indicator resets the timer.
        ///   - contentSizingMode: Size of the indicator (excluding shadows).
        ///   - contentPadding: Padding to apply around the content area inside the indicator.
        ///   - horizontalItemSpacing: Spacing between various items inside the content area of the indicator (e.g. image view and text area).
        ///   - titleColor: Indicator's title color
        ///   - subtitleColor: Indicator's subtitle color
        ///   - backgroundColor: Indicator's background color
        ///   - titleFont: Indicator's title font
        ///   - subtitleFont: Indicator's subtitle font
        public init(
            tap: Action? = nil,
            appeared: Action? = nil,
            dismissed: Action? = nil,
            duration: TimeInterval? = nil,
            contentSizingMode: ContentSizingMode? = nil,
            contentPadding: UIEdgeInsets? = nil,
            horizontalItemSpacing: CGFloat? = nil,
            titleColor: UIColor? = nil,
            subtitleColor: UIColor? = nil,
            backgroundColor: UIColor? = nil,
            titleFont: UIFont? = nil,
            subtitleFont: UIFont? = nil
        ) {
            self.tap = tap
            self.appeared = appeared
            self.dismissed = dismissed
            self.duration = duration ?? Self.defaultDuration
            self.contentPadding = contentPadding ?? Self.defaultContentPadding
            self.contentSizingMode = contentSizingMode ?? .custom(Self.defaultSize)
            self.horizontalItemSpacing = horizontalItemSpacing ?? Self.defaultHorizontalItemSpacing
            self.titleColor = titleColor ?? Self.defaultTitleColor
            self.subtitleColor = subtitleColor ?? Self.defaultSubtitleColor
            self.backgroundColor = backgroundColor ?? Self.defaultBackgroundColor
            self.titleFont = titleFont ?? Self.defaultTitleFont
            self.subtitleFont = subtitleFont ?? Self.defaultSubtitleFont
        }
    }
}

// MARK: Indicate.Configuration > Withs

extension Indicate.Configuration {
    
    /// Create a copy of the current configuration structure with a new `tap` handler.
    public func with(tap: Action?) -> Self {
        return Indicate.Configuration(
            tap: tap,
            appeared: appeared,
            dismissed: dismissed,
            duration: duration,
            contentSizingMode: contentSizingMode,
            contentPadding: contentPadding,
            horizontalItemSpacing: horizontalItemSpacing,
            titleColor: titleColor,
            subtitleColor: subtitleColor,
            backgroundColor: backgroundColor,
            titleFont: titleFont,
            subtitleFont: subtitleFont
        )
    }
    
    /// Create a copy of the current configuration structure with a new `appeared` handler
    public func with(appeared: Action?) -> Self {
        return Indicate.Configuration(
            tap: tap,
            appeared: appeared,
            dismissed: dismissed,
            duration: duration,
            contentSizingMode: contentSizingMode,
            contentPadding: contentPadding,
            horizontalItemSpacing: horizontalItemSpacing,
            titleColor: titleColor,
            subtitleColor: subtitleColor,
            backgroundColor: backgroundColor,
            titleFont: titleFont,
            subtitleFont: subtitleFont
        )
    }
    
    
    /// Create a copy of the current configuration structure with a new `dismissed` handler
    public func with(dismissed: Action?) -> Self {
        return Indicate.Configuration(
            tap: tap,
            appeared: appeared,
            dismissed: dismissed,
            duration: duration,
            contentSizingMode: contentSizingMode,
            contentPadding: contentPadding,
            horizontalItemSpacing: horizontalItemSpacing,
            titleColor: titleColor,
            subtitleColor: subtitleColor,
            backgroundColor: backgroundColor,
            titleFont: titleFont,
            subtitleFont: subtitleFont
        )
    }
    
    
    /// Create a copy of the current configuration structure with a new `duration` value
    public func with(duration: TimeInterval) -> Self {
        return Indicate.Configuration(
            tap: tap,
            appeared: appeared,
            dismissed: dismissed,
            duration: duration,
            contentSizingMode: contentSizingMode,
            contentPadding: contentPadding,
            horizontalItemSpacing: horizontalItemSpacing,
            titleColor: titleColor,
            subtitleColor: subtitleColor,
            backgroundColor: backgroundColor,
            titleFont: titleFont,
            subtitleFont: subtitleFont
        )
    }
    
    
    /// Create a copy of the current configuration structure with a new `contentSizingMode` value
    public func with(contentSizingMode: ContentSizingMode) -> Self {
        return Indicate.Configuration(
            tap: tap,
            appeared: appeared,
            dismissed: dismissed,
            duration: duration,
            contentSizingMode: contentSizingMode,
            contentPadding: contentPadding,
            horizontalItemSpacing: horizontalItemSpacing,
            titleColor: titleColor,
            subtitleColor: subtitleColor,
            backgroundColor: backgroundColor,
            titleFont: titleFont,
            subtitleFont: subtitleFont
        )
    }
    
    
    /// Create a copy of the current configuration structure with a new `contentPadding` value
    public func with(contentPadding: UIEdgeInsets) -> Self {
        return Indicate.Configuration(
            tap: tap,
            appeared: appeared,
            dismissed: dismissed,
            duration: duration,
            contentSizingMode: contentSizingMode,
            contentPadding: contentPadding,
            horizontalItemSpacing: horizontalItemSpacing,
            titleColor: titleColor,
            subtitleColor: subtitleColor,
            backgroundColor: backgroundColor,
            titleFont: titleFont,
            subtitleFont: subtitleFont
        )
    }
    
    /// Create a copy of the current configuration structure with a new `horizontalItemSpacing` value
    public func with(horizontalItemSpacing: CGFloat) -> Self {
        return Indicate.Configuration(
            tap: tap,
            appeared: appeared,
            dismissed: dismissed,
            duration: duration,
            contentSizingMode: contentSizingMode,
            contentPadding: contentPadding,
            horizontalItemSpacing: horizontalItemSpacing,
            titleColor: titleColor,
            subtitleColor: subtitleColor,
            backgroundColor: backgroundColor,
            titleFont: titleFont,
            subtitleFont: subtitleFont
        )
    }
    
    /// Create a copy of the current configuration structure with a new `titleColor` value
    public func with(titleColor: UIColor) -> Self {
        return Indicate.Configuration(
            tap: tap,
            appeared: appeared,
            dismissed: dismissed,
            duration: duration,
            contentSizingMode: contentSizingMode,
            contentPadding: contentPadding,
            horizontalItemSpacing: horizontalItemSpacing,
            titleColor: titleColor,
            subtitleColor: subtitleColor,
            backgroundColor: backgroundColor,
            titleFont: titleFont,
            subtitleFont: subtitleFont
        )
    }
    
    /// Create a copy of the current configuration structure with a new `subtitleColor` value
    public func with(subtitleColor: UIColor) -> Self {
        return Indicate.Configuration(
            tap: tap,
            appeared: appeared,
            dismissed: dismissed,
            duration: duration,
            contentSizingMode: contentSizingMode,
            contentPadding: contentPadding,
            horizontalItemSpacing: horizontalItemSpacing,
            titleColor: titleColor,
            subtitleColor: subtitleColor,
            backgroundColor: backgroundColor,
            titleFont: titleFont,
            subtitleFont: subtitleFont
        )
    }
    
    /// Create a copy of the current configuration structure with a new `backgroundColor` value
    public func with(backgroundColor: UIColor) -> Self {
        return Indicate.Configuration(
            tap: tap,
            appeared: appeared,
            dismissed: dismissed,
            duration: duration,
            contentSizingMode: contentSizingMode,
            contentPadding: contentPadding,
            horizontalItemSpacing: horizontalItemSpacing,
            titleColor: titleColor,
            subtitleColor: subtitleColor,
            backgroundColor: backgroundColor,
            titleFont: titleFont,
            subtitleFont: subtitleFont
        )
    }
    
    /// Create a copy of the current configuration structure with a new `titleFont` value
    public func with(titleFont: UIFont) -> Self {
        return Indicate.Configuration(
            tap: tap,
            appeared: appeared,
            dismissed: dismissed,
            duration: duration,
            contentSizingMode: contentSizingMode,
            contentPadding: contentPadding,
            horizontalItemSpacing: horizontalItemSpacing,
            titleColor: titleColor,
            subtitleColor: subtitleColor,
            backgroundColor: backgroundColor,
            titleFont: titleFont,
            subtitleFont: subtitleFont
        )
    }
    
    /// Create a copy of the current configuration structure with a new `subtitleFont` value
    public func with(subtitleFont: UIFont) -> Self {
        return Indicate.Configuration(
            tap: tap,
            appeared: appeared,
            dismissed: dismissed,
            duration: duration,
            contentSizingMode: contentSizingMode,
            contentPadding: contentPadding,
            horizontalItemSpacing: horizontalItemSpacing,
            titleColor: titleColor,
            subtitleColor: subtitleColor,
            backgroundColor: backgroundColor,
            titleFont: titleFont,
            subtitleFont: subtitleFont
        )
    }
}
