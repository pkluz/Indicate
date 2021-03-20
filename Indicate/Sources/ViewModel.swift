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
                .foregroundColor: UIColor(named: "TitleColor", in: Bundle(for: Self.self), compatibleWith: nil) ?? UIColor.black,
                .font: UIFont.boldSystemFont(ofSize: 13.0),
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
                .foregroundColor: UIColor(named: "SubtitleColor", in: Bundle(for: Self.self), compatibleWith: nil) ?? UIColor.darkGray,
                .font: UIFont.boldSystemFont(ofSize: 13.0),
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
        
        internal let size: CGSize
        
        internal let contentPadding: UIEdgeInsets
        
        internal let horizontalItemSpacing: CGFloat
        
        // MARK: ViewModel (Private Properties)
        
        private let content: Content
        
        // MARK: ViewModel (internal Methods)
        
        internal init(content: Content, size: CGSize, contentPadding: UIEdgeInsets, horizontalItemSpacing: CGFloat) {
            self.content = content
            self.size = size
            self.contentPadding = contentPadding
            self.horizontalItemSpacing = horizontalItemSpacing
        }
    }
}
