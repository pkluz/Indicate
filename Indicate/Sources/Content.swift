//
//  Message.swift
//  Indicate
//
//  Created by Philip Kluz on 2021-03-07.
//  Copyright © 2021 Philip Kluz. All rights reserved.
//

import UIKit

// MARK: Indicate.Content > Text

extension Indicate.Content {
    
    public struct Text {
        
        public let value: String
        public let alignment: NSTextAlignment
        
        public init(value: String, alignment: NSTextAlignment = .center) {
            self.value = value
            self.alignment = alignment
        }
    }
}

// MARK: Indicate.Content > Image

extension Indicate.Content {
    
    public struct Image {
        
        public let value: UIImage?
        public let alignment: NSTextAlignment
        
        public init(value: UIImage?, alignment: NSTextAlignment = .natural) {
            self.value = value
            self.alignment = alignment
        }
    }
}

// MARK: Indicate.Content > Emoji

extension Indicate.Content {
    
    public struct Emoji {
        
        public enum Error: Swift.Error {
            case characterIsNotEmoji
        }
        
        public let value: String?
        public let alignment: NSTextAlignment
        
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

// MARK: Indicate > Content

extension Indicate {
    
    public struct Content {
        
        public enum Attachment {
            case image(Image)
            case emoji(Emoji)
            
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
        
        public let title: Text
        public let subtitle: Text?
        public let attachment: Attachment?
        
        // MARK: Content (Public Methods)
        
        public init(title: Text, subtitle: Text? = nil, attachment: Attachment? = nil) {
            self.title = title
            self.subtitle = subtitle
            self.attachment = attachment
        }
    }
}

// MARK: Indicate.Content > Withs

extension Indicate.Content {
    
    public func with(title: Text) -> Self {
        return Indicate.Content(title: title, subtitle: subtitle, attachment: attachment)
    }
    
    public func with(subtitle: Text?) -> Self {
        return Indicate.Content(title: title, subtitle: subtitle, attachment: attachment)
    }
    
    public func with(attachment: Attachment?) -> Self {
        return Indicate.Content(title: title, subtitle: subtitle, attachment: attachment)
    }
}
