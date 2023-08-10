//
//  MyTagItemCustomRemovableView.swift
//  MyTagCollection
//
//  Created by Neil Francis Hipona on 8/10/23.
//

import Foundation

public
extension MyTagItemCustomRemovableView {
    // MyTagItemAttribute.defaultStub
    enum CustomTagViewConstraint {
        static let verticalPadding: CGFloat = 11
        static let horizontalPadding: CGFloat = 20
        static let titleLabelHeight: CGFloat = 18
    }
}

public
class MyTagItemCustomRemovableView: MyTagBaseItemView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14,
                                       weight: .regular)
        return label.usingAutolayout()
    }()
    
    @objc private let tapAction: UIButton = {
        let button = UIButton()
        let bundle = Bundle(for: MyTagItemCustomRemovableView.self)
        let image = UIImage(named: "remove",
                            in: bundle,
                            compatibleWith: .none)
        button.setImage(image, for: .normal)
        button.clipsToBounds = true
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
        titleLabel.trailingAnchor.constraint(equalTo: tapAction.leadingAnchor,
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

            tapAction.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            tapAction.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            tapAction.widthAnchor.constraint(equalToConstant: 30),
            tapAction.heightAnchor.constraint(equalToConstant: 30)
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
        
        setBindings()
        layoutIfNeeded()
    }
    
    private func setBindings() {
        tapAction.addTarget(self, action: #selector(tapAction(sender:)), for: .touchUpInside)
    }
    
    @objc
    private func tapAction(sender: UIButton) {
        guard let parent, let item else { return }
        parent.childItem(tagItem: item,
                         tagView: self,
                         requestAction: .remove)
    }
}
