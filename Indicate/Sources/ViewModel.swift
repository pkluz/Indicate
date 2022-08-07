//
//  ViewModel.swift
//  Indicate
//
//  Created by Philip Kluz on 2021-03-07.
//  Copyright © 2021 Philip Kluz. All rights reserved.
//

import UIKit

extension Indicate {
    
    internal final class ViewModel {
        
        // MARK: ViewModel (internal Properties)
        
        internal lazy var attributedTitle: NSAttributedString = {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = content.title.alignment
            paragraphStyle.lineBreakMode = .byTruncatingTail
            
            let attributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: titleColor,
                .font: titleFont,
                .paragraphStyle: paragraphStyle
            ]
            
            return NSAttributedString(string: content.title.value, attributes: attributes)
        }()
        
        internal lazy var attributedSubtitle: NSAttributedString? = {
            guard let subtitle = content.subtitle else { return nil }
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = subtitle.alignment
            paragraphStyle.lineBreakMode = .byTruncatingTail
            
            let attributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: subtitleColor,
                .font: subtitleFont,
                .paragraphStyle: paragraphStyle
            ]
            
            return NSAttributedString(string: subtitle.value, attributes: attributes)
        }()
        
        internal lazy var attributedCompositeTitle: NSAttributedString = {
            guard let attributedSubtitle = attributedSubtitle, attributedSubtitle.length > 0 else { return attributedTitle }
            
            let result = NSMutableAttributedString()
            result.append(attributedTitle)
            result.append(NSAttributedString(string: "\n"))
            result.append(attributedSubtitle)
            
            return result
        }()
        
        internal var hasAttachment: Bool {
            switch content.attachment {
            case .emoji(let emoji):
                return emoji.value != nil
            case .image(let image):
                return image.value != nil
            case .none:
                return false
            }
        }
        
        internal var emoji: String? {
            switch content.attachment {
            case .emoji(let emoji):
                return emoji.value
            default:
                return nil
            }
        }
        
        internal var isEmojiLabelHidden: Bool {
            guard let emoji = emoji else { return true }
            return emoji.isEmpty
        }
        
        internal var isEmojiLabelLeftAligned: Bool {
            guard let attachment = content.attachment else { return true }
            return attachment.alignment == .left || (attachment.alignment == .natural && UIApplication.shared.userInterfaceLayoutDirection == .leftToRight)
        }
        
        internal var image: UIImage? {
            switch content.attachment {
            case .image(let image):
                return image.value
            default:
                return nil
            }
        }
        
        internal var isImageViewHidden: Bool {
            guard let image = image else { return true }
            return image.size.width == 0.0 || image.size.height == 0.0
        }
        
        internal var isImageViewLeftAligned: Bool {
            guard let attachment = content.attachment else { return true }
            return attachment.alignment == .left || (attachment.alignment == .natural && UIApplication.shared.userInterfaceLayoutDirection == .leftToRight)
        }
        
        internal let contentSizingMode: Configuration.ContentSizingMode
        
        internal let contentPadding: UIEdgeInsets
        
        internal let horizontalItemSpacing: CGFloat

        internal let titleColor: UIColor

        internal let subtitleColor: UIColor

        internal let backgroundColor: UIColor

        internal let titleFont: UIFont

        internal let subtitleFont: UIFont
        
        // MARK: ViewModel (Private Properties)
        
        private let content: Content
        
        // MARK: ViewModel (internal Methods)
        
        internal init(
            content: Content,
            contentSizingMode: Configuration.ContentSizingMode,
            contentPadding: UIEdgeInsets,
            horizontalItemSpacing: CGFloat,
            titleColor: UIColor,
            subtitileColor: UIColor,
            backgroundColor: UIColor,
            titleFont: UIFont,
            subtitleFont: UIFont
        ) {
            self.content = content
            self.contentSizingMode = contentSizingMode
            self.contentPadding = contentPadding
            self.horizontalItemSpacing = horizontalItemSpacing
            self.titleColor = titleColor
            self.subtitleColor = subtitileColor
            self.backgroundColor = backgroundColor
            self.titleFont = titleFont
            self.subtitleFont = subtitleFont
        }
    }
}
