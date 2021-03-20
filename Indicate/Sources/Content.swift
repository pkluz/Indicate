//
//  Content.swift
//  Indicate
//
//  Created by Philip Kluz on 2021-03-07.
//  Copyright © 2021 Philip Kluz. All rights reserved.
//

import UIKit

// MARK: Indicate > Content

extension Indicate {
    
    /// Structure defining the contents of the indicator.
    public struct Content {
        
        /// An attachment is either an image or an emoji (displayed a prominent position) alongside the text contents of the indicator.
        public enum Attachment {
            case image(Image)
            case emoji(Emoji)
            
            /// The alignment of the indicator. At this time only `left` and `right` are supported. If a different value is supplied, `left` will be used.
            public var alignment: NSTextAlignment {
                switch self {
                case .emoji(let emoji):
                    return emoji.alignment
                case .image(let image):
                    return image.alignment
                }
            }
        }

        // MARK: Content (Public Properties)
        
        /// Title text to be displayed inside the indicator. Prominent appearance.
        public let title: Text
        
        /// Subtitle to be displayed inside the indicator. If not supplied, title will be centered vertically. **Optional**.
        public let subtitle: Text?
        
        /// Attachment to be displayed in a prominent position alongside the text contents of the indicator. **Optional**.
        public let attachment: Attachment?
        
        // MARK: Content (Public Methods)
        
        /// Instantiate a new `Content` structure.
        ///
        /// - Parameters:
        ///   - title: Title text to be displayed inside the indicator. Prominent appearance.
        ///   - subtitle: Subtitle to be displayed inside the indicator. If not supplied, title will be centered vertically. **Optional**.
        ///   - attachment: Attachment to be displayed in a prominent position alongside the text contents of the indicator. **Optional**.
        public init(title: Text, subtitle: Text? = nil, attachment: Attachment? = nil) {
            self.title = title
            self.subtitle = subtitle
            self.attachment = attachment
        }
    }
}

// MARK: Indicate.Content > Withs

extension Indicate.Content {
    
    /// Create a copy of the current content structure with a new `title` value.
    public func with(title: Text) -> Self {
        return Indicate.Content(title: title, subtitle: subtitle, attachment: attachment)
    }
    
    /// Create a copy of the current content structure with a new `subtitle` value.
    public func with(subtitle: Text?) -> Self {
        return Indicate.Content(title: title, subtitle: subtitle, attachment: attachment)
    }
    
    /// Create a copy of the current content structure with a new `attachment` value.
    public func with(attachment: Attachment?) -> Self {
        return Indicate.Content(title: title, subtitle: subtitle, attachment: attachment)
    }
}

// MARK: Indicate.Content > Text

extension Indicate.Content {
    
    /// Wrapper around a regular `String` with additional alignment metadata.
    public struct Text {
        
        /// Underlying value.
        public let value: String
        
        /// Alignment for the subsequent visual representation.
        public let alignment: NSTextAlignment
        
        /// Instantiate a new `Text` structure.
        ///
        /// - Parameters:
        ///   - value: Underlying value.
        ///   - alignment: Alignment for the subsequent visual representation.
        public init(value: String, alignment: NSTextAlignment = .natural) {
            self.value = value
            self.alignment = alignment
        }
    }
}

// MARK: Indicate.Content > Image

extension Indicate.Content {
    
    /// Wrapper around a regular `UIImage` with additional alignment metadata.
    public struct Image {
        
        /// Underlying value.
        public let value: UIImage?
        
        /// Alignment for the subsequent visual representation.
        public let alignment: NSTextAlignment
        
        /// Instantiate a new `Image` structure.
        ///
        /// - Parameters:
        ///   - value: Underlying value.
        ///   - alignment: Alignment for the subsequent visual representation.
        public init(value: UIImage?, alignment: NSTextAlignment = .natural) {
            self.value = value
            self.alignment = alignment
        }
    }
}

// MARK: Indicate.Content > Emoji

extension Indicate.Content {
    
    /// Wrapper around a regular `String` (constrained to the emoji unicode space) with additional alignment metadata.
    public struct Emoji {
        
        public enum Error: Swift.Error {
            case characterIsNotEmoji
        }
        
        /// Underlying value.
        public let value: String?
        
        /// Alignment for the subsequent visual representation.
        public let alignment: NSTextAlignment
        
        /// Instantiate a new `Emoji` structure.
        ///
        /// - Parameters:
        ///   - value: Underlying value.
        ///   - alignment: Alignment for the subsequent visual representation.
        public init(value: String, alignment: NSTextAlignment = .natural) {
            guard value.count == 1, value.unicodeScalars.allSatisfy({ $0.properties.isEmojiPresentation }) else {
                print("WARNING (Indicate): Supplied value (= \"\(value)\" is not a valid emoji character. Will not render.")
                self.value = nil
                self.alignment = alignment
                return
            }
            
            self.value = value
            self.alignment = alignment
        }
    }
}
