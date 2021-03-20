//
//  View.swift
//  Indicate
//
//  Created by Philip Kluz on 2021-03-07.
//  Copyright © 2021 Philip Kluz. All rights reserved.
//

import UIKit

// MARK: Indicate > View

extension Indicate {
    
    internal final class View: UIView {
        
        // MARK: NSObject
        
        internal required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        // MARK: UIView
        
        internal override func layoutSubviews() {
            super.layoutSubviews()
            
            contentView.frame = CGRect(x: viewModel.contentPadding.left,
                                       y: viewModel.contentPadding.top,
                                       width: bounds.width - viewModel.contentPadding.left - viewModel.contentPadding.right,
                                       height: bounds.height - viewModel.contentPadding.top - viewModel.contentPadding.bottom)
            
            imageView.frame = {
                if viewModel.isImageViewHidden {
                    return .zero
                }
                
                if viewModel.isImageViewLeftAligned {
                    return CGRect(x: 0.0,
                                  y: 0.0,
                                  width: contentView.bounds.height,
                                  height: contentView.bounds.height)
                }
                
                return CGRect(x: contentView.bounds.width - contentView.bounds.height,
                              y: 0.0,
                              width: contentView.bounds.height,
                              height: contentView.bounds.height)
            }()
            
            emojiLabel.frame = {
                if viewModel.isEmojiLabelHidden {
                    return .zero
                }
                
                if viewModel.isEmojiLabelLeftAligned {
                    return CGRect(x: 0.0,
                                  y: 0.0,
                                  width: contentView.bounds.height,
                                  height: contentView.bounds.height)
                }
                
                return CGRect(x: contentView.bounds.width - contentView.bounds.height,
                              y: 0.0,
                              width: contentView.bounds.height,
                              height: contentView.bounds.height)
            }()
            
            titleLabel.frame = {
                if viewModel.isImageViewHidden && viewModel.isEmojiLabelHidden {
                    return contentView.bounds
                }
                
                if viewModel.isImageViewLeftAligned || viewModel.isEmojiLabelLeftAligned {
                    let x = max(imageView.bounds.maxX, emojiLabel.bounds.maxX) + viewModel.horizontalItemSpacing
                    return CGRect(x: x,
                                  y: 0.0,
                                  width: contentView.bounds.width - x,
                                  height: contentView.bounds.height)
                }
                
                return CGRect(x: 0.0,
                              y: 0.0,
                              width: contentView.bounds.width - viewModel.horizontalItemSpacing - max(imageView.bounds.width, emojiLabel.bounds.width),
                              height: contentView.bounds.height)
            }()
            
            refreshAppearance()
        }
        
        internal override func sizeThatFits(_ size: CGSize) -> CGSize {
            let titleSize = titleLabel.sizeThatFits(size)
            let attachmentWidth = viewModel.hasAttachment ? viewModel.size.height - (viewModel.contentPadding.top + viewModel.contentPadding.bottom) : 0.0
            let size = CGSize(width: min(viewModel.size.width, viewModel.contentPadding.left + attachmentWidth + viewModel.horizontalItemSpacing + titleSize.width + viewModel.contentPadding.right),
                              height: viewModel.size.height)
            
            return size
        }
        
        internal override func systemLayoutSizeFitting(_ targetSize: CGSize) -> CGSize {
            return sizeThatFits(targetSize)
        }
        
        internal override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
            return sizeThatFits(targetSize)
        }
        
        // MARK: View (Internal Properties)
        
        internal var viewModel: ViewModel {
            didSet {
                refreshAppearance()
                setNeedsLayout()
            }
        }
        
        // MARK: View (Private Properties)
        
        private lazy var contentView: UIView = UIView()
        
        private lazy var emojiLabel: UILabel = {
            let label = UILabel()
            label.textColor = UIColor(named: "TitleColor", in: Bundle(for: Self.self), compatibleWith: nil)
            label.font = UIFont.boldSystemFont(ofSize: 30.0)
            label.adjustsFontSizeToFitWidth = true
            label.contentMode = .center
            label.textAlignment = .center
            label.numberOfLines = 1
            return label
        }()
        
        private lazy var titleLabel: UILabel = {
            let label = UILabel()
            label.textColor = UIColor(named: "TitleColor", in: Bundle(for: Self.self), compatibleWith: nil)
            label.font = UIFont.boldSystemFont(ofSize: 13.0)
            label.textAlignment = .center
            label.numberOfLines = 2
            return label
        }()
        
        private lazy var imageView: UIImageView = {
            let imageView = UIImageView(image: nil)
            imageView.contentMode = .scaleAspectFit
            imageView.clipsToBounds = true
            return imageView
        }()

        // MARK: View (Public Methods)
        
        internal init(viewModel: ViewModel) {
            self.viewModel = viewModel
            
            super.init(frame: .zero)
            
            autoresizingMask = [ .flexibleLeftMargin, .flexibleRightMargin ]
            
            addSubview(contentView)
            contentView.addSubview(titleLabel)
            contentView.addSubview(imageView)
            contentView.addSubview(emojiLabel)
            
            refreshAppearance()
        }
        
        // MARK: View (Private Methods)
        
        private func refreshAppearance() {
            layer.backgroundColor = (UIColor(named: "BackgroundColor", in: Bundle(for: Self.self), compatibleWith: nil) ?? UIColor.white).cgColor
            if #available(iOS 13.0, *) {
                layer.cornerCurve = .continuous
            }
            layer.cornerRadius = min(bounds.width, bounds.height) / 2.0
            layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOpacity = 0.1
            layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
            layer.shadowRadius = 14.0
            
            // NOTE: This scales the emoji's font to always be 60% of the smallest dimension's magnitude.
            emojiLabel.font = UIFont.boldSystemFont(ofSize: floor(min(bounds.width, bounds.height) * (3.0 / 5.0)))
            
            titleLabel.attributedText = viewModel.attributedCompositeTitle
            imageView.isHidden = viewModel.isImageViewHidden
            imageView.image = viewModel.image
            emojiLabel.text = viewModel.emoji
        }
    }
}
