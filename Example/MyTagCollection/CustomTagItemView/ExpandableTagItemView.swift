//
//  ExpandableTagItemView.swift
//  MyTagCollection_Example
//
//  Created by Neil Francis Hipona on 8/27/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation
import MyTagCollection

extension ExpandableTagItemView {
    // MyTagItemAttribute.defaultStub
    enum CustomTagViewConstraint {
        static let verticalPadding: CGFloat = 11
        static let horizontalPadding: CGFloat = 20
        static let titleLabelHeight: CGFloat = 18
    }
}

class ExpandableTagItemView: MyTagBaseItemView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14,
                                       weight: .regular)
        return label.usingAutolayout()
    }()
    
    @objc private let tapAction: UIButton = {
        let button = UIButton()
        return button.usingAutolayout()
    }()
    
    private
    lazy var titleLabelTopAnchor: NSLayoutConstraint = {
        titleLabel.topAnchor.constraint(equalTo: topAnchor,
                                        constant: CustomTagViewConstraint.verticalPadding)
    }()
    
    private
    lazy var titleLabelLeadingAnchor: NSLayoutConstraint = {
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor,
                                            constant: CustomTagViewConstraint.horizontalPadding)
    }()
    
    private
    lazy var titleLabelTrailingAnchor: NSLayoutConstraint = {
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor,
                                             constant: -CustomTagViewConstraint.horizontalPadding)
    }()
    
    private
    lazy var titleLabelBotAnchor: NSLayoutConstraint = {
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor,
                                           constant: -CustomTagViewConstraint.horizontalPadding)
    }()
    
    private
    lazy var titleLabelHeightAnchor: NSLayoutConstraint = {
        titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: CustomTagViewConstraint.titleLabelHeight)
    }()

    override func setViews() {
        addSubviews([titleLabel, tapAction])
    }
    
    override func setConstraints() {
        NSLayoutConstraint.activate([
            titleLabelTopAnchor,
            titleLabelLeadingAnchor,
            titleLabelTrailingAnchor,
            titleLabelBotAnchor,
            titleLabelHeightAnchor,
            
            tapAction.topAnchor.constraint(equalTo: topAnchor),
            tapAction.leadingAnchor.constraint(equalTo: leadingAnchor),
            tapAction.trailingAnchor.constraint(equalTo: trailingAnchor),
            tapAction.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    override func configure(item: MyTagItemProtocol) {
        super.configure(item: item)
        
        titleLabel.text = item.model.title
        titleLabel.accessibilityLabel = item.model.title
        tapAction.accessibilityLabel = "Tag Action"
        
        titleLabelTopAnchor.constant = item.attribute.topPadding
        titleLabelLeadingAnchor.constant = item.attribute.leftPadding
        titleLabelTrailingAnchor.constant = -item.attribute.rightPadding
        titleLabelBotAnchor.constant = -item.attribute.bottomPadding
        titleLabelHeightAnchor.constant = item.attribute.titleLabelHeight
        
        setBindings()
        layoutIfNeeded()
    }
    
    private func setBindings() {
        tapAction.addTarget(self, action: #selector(tapAction(sender:)), for: .touchUpInside)
    }
    
    @objc
    private func tapAction(sender: UIButton) {
        guard let parent, let item = item as? ExpandableTagItemViewModel else { return }
        if item.isSelected {
            parent.childItem(tagItem: item,
                             tagView: self,
                             requestAction: .collapse)
        } else {
            parent.childItem(tagItem: item,
                             tagView: self,
                             requestAction: .expandWith(expandedItem: item.expandedItem))
        }
    }
}
