//
//  MyTagItemCustomView.swift
//  MyTagCollection
//
//  Created by Neil Francis Hipona on 8/7/23.
//

import Foundation

public
extension MyTagItemCustomView {
    // MyTagItemAttribute.defaultStub
    enum CustomTagViewConstraint {
        static let padding8: CGFloat = 8
        static let verticalPadding: CGFloat = 11
        static let horizontalPadding: CGFloat = 20
        static let titleLabelHeight: CGFloat = 18
    }
}

public
class MyTagItemCustomView: MyTagBaseItemView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label.usingAutolayout()
    }()
    
    private let tapAction: UIButton = {
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
    
    public
    override func setViews() {
        super.setViews()
        addSubviews([titleLabel, tapAction])
    }
    
    public
    override func setConstraints() {
        super.setConstraints()
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
    
    public
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
        
        layoutIfNeeded()
    }
}
