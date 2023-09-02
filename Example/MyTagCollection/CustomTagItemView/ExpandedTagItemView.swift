//
//  ExpandedTagItemView.swift
//  MyTagCollection_Example
//
//  Created by Neil Francis Hipona on 8/27/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation
import MyTagCollection

class ExpandedTagItemView: MyTagBaseExpandableItemView {
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "expanded")
        return imageView.usingAutolayout()
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 22,
                                       weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        return label.usingAutolayout()
    }()
    
    @objc private let tapAction: UIButton = {
        let button = UIButton()
        return button.usingAutolayout()
    }()

    override func setViews() {
        backgroundColor = .gray
        layer.cornerRadius = 20
        clipsToBounds = true
        addSubviews([imageView, titleLabel, tapAction])
    }
    
    override func setConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            
            tapAction.topAnchor.constraint(equalTo: topAnchor),
            tapAction.leadingAnchor.constraint(equalTo: leadingAnchor),
            tapAction.trailingAnchor.constraint(equalTo: trailingAnchor),
            tapAction.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    override func configure(item: MyTagExpandableItemProtocol) {
        super.configure(item: item)
        guard let item = item as? ExpandedTagItemViewModel else { return }
        titleLabel.text = item.model.title
        titleLabel.accessibilityLabel = item.model.title
        tapAction.accessibilityLabel = "Tag Action"
        
        setBindings()
        layoutIfNeeded()
    }
    
    private func setBindings() {
        tapAction.addTarget(self, action: #selector(tapAction(sender:)), for: .touchUpInside)
    }
    
    @objc
    private func tapAction(sender: UIButton) {
        print("did tap on expanded tag item view!")
    }
}
