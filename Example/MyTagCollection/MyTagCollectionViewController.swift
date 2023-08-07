//
//  MyTagCollectionViewController.swift
//  MyTagCollection_Example
//
//  Created by Neil Francis Hipona on 8/7/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation
import MyTagCollection

class MyTagCollectionViewController: UIViewController {
    private var alignment: MyTagSection.Alignment
    private var initialItems: [MyTagItemCustomViewModel]
    
    private
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = alignment.description
        label.font = UIFont.systemFont(ofSize: 30,
                                       weight: .bold)
        return label.usingAutolayout()
    }()
    
    private
    lazy var myTagCollectionViewModel: MyTagCollectionViewModel = {
        .init(identifier: UUID().uuidString,
              items: initialItems,
              dimension: .defaultStub,
              alignment: alignment)
    }()
    
    private
    lazy var myTagCollectionView: MyTagCollectionView = {
        .init(viewModel: myTagCollectionViewModel)
        .usingAutolayout()
    }()
    
    init(alignment: MyTagSection.Alignment, initialItems: [MyTagItemCustomViewModel]) {
        self.alignment = alignment
        self.initialItems = initialItems
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .white
        title = "My Tags Collection"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubviews([titleLabel, myTagCollectionView])
        setConstraints()
    }

    private func setConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 30),
            
            myTagCollectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            myTagCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            myTagCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            myTagCollectionView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -50)
        ])
    }
}

