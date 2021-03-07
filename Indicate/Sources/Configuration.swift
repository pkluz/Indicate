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
    
    public struct Configuration {
        
        public typealias Action = (PresentationController) -> Void
        
        // MARK: Configuration (Public Properties)
        
        public let tap: Action?
        
        public let appeared: Action?
        
        public let dismissed: Action?
        
        public let size: CGSize
        
        public let contentPadding: UIEdgeInsets
        
        public let horizontalItemSpacing: CGFloat
        
        public static let `default`: Configuration = Configuration()
        
        // MARK: Configuration (Private Static  Properties)
        
        private static let defaultSize: CGSize = CGSize(width: 215.0, height: 50.0)
        
        private static let defaultContentPadding: UIEdgeInsets = UIEdgeInsets(top: 8.0, left: 12.0, bottom: 8.0, right: 12.0)
        
        private static let defaultHorizontalItemSpacing: CGFloat = 8.0
        
        // MARK: Configuration (Public Methods)
        
        public init(tap: Action? = nil, appeared: Action? = nil, dismissed: Action? = nil, size: CGSize? = nil, contentPadding: UIEdgeInsets? = nil, horizontalItemSpacing: CGFloat? = nil) {
            self.tap = tap
            self.appeared = appeared
            self.dismissed = dismissed
            self.contentPadding = contentPadding ?? Self.defaultContentPadding
            self.size = size ?? Self.defaultSize
            self.horizontalItemSpacing = horizontalItemSpacing ?? Self.defaultHorizontalItemSpacing
        }
    }
}

// MARK: Indicate.Configuration > Withs

extension Indicate.Configuration {
    
    public func with(tap: Action?) -> Self {
        return Indicate.Configuration(tap: tap, appeared: appeared, dismissed: dismissed, size: size, contentPadding: contentPadding, horizontalItemSpacing: horizontalItemSpacing)
    }
    
    public func with(appeared: Action?) -> Self {
        return Indicate.Configuration(tap: tap, appeared: appeared, dismissed: dismissed, size: size, contentPadding: contentPadding, horizontalItemSpacing: horizontalItemSpacing)
    }
    
    public func with(dismissed: Action?) -> Self {
        return Indicate.Configuration(tap: tap, appeared: appeared, dismissed: dismissed, size: size, contentPadding: contentPadding, horizontalItemSpacing: horizontalItemSpacing)
    }
    
    public func with(size: CGSize) -> Self {
        return Indicate.Configuration(tap: tap, appeared: appeared, dismissed: dismissed, size: size, contentPadding: contentPadding, horizontalItemSpacing: horizontalItemSpacing)
    }
    
    public func with(contentPadding: UIEdgeInsets) -> Self {
        return Indicate.Configuration(tap: tap, appeared: appeared, dismissed: dismissed, size: size, contentPadding: contentPadding, horizontalItemSpacing: horizontalItemSpacing)
    }
    
    public func with(horizontalItemSpacing: CGFloat) -> Self {
        return Indicate.Configuration(tap: tap, appeared: appeared, dismissed: dismissed, size: size, contentPadding: contentPadding, horizontalItemSpacing: horizontalItemSpacing)
    }
}
