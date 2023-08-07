//
//  ViewController.swift
//  MyTagCollection
//
//  Created by Neil Francis Ramirez Hipona on 08/06/2023.
//  Copyright (c) 2023 Neil Francis Ramirez Hipona. All rights reserved.
//

import UIKit
import MyTagCollection

class ViewController: UIViewController {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "My Tags Collection"
        label.font = UIFont.systemFont(ofSize: 30,
                                       weight: .bold)
        return label.usingAutolayout()
    }()
    
    private
    lazy var initialItems: [MyTagItemCustomViewModel] = {
        [
            .init(identifier: UUID().uuidString,
                  model: MyTagItemModel(title: "Tag 1",
                                        value: "Tag 1"),
                  attribute: MyTagItemAttribute.defaultStub),
            .init(identifier: UUID().uuidString,
                  model: MyTagItemModel(title: "Tag 2",
                                        value: "Tag 2"),
                  attribute: MyTagItemAttribute.defaultStub),
            .init(identifier: UUID().uuidString,
                  model: MyTagItemModel(title: "Tag Long Title",
                                        value: "Tag 3"),
                  attribute: MyTagItemAttribute.defaultStub),
            .init(identifier: UUID().uuidString,
                  model: MyTagItemModel(title: "Tag Very Long Title",
                                        value: "Tag 4"),
                  attribute: MyTagItemAttribute.defaultStub),
            .init(identifier: UUID().uuidString,
                  model: MyTagItemModel(title: "Tag Very Very Very Very Long Title",
                                        value: "Tag 5"),
                  attribute: MyTagItemAttribute.defaultStub)
        ]
    }()
    
    private
    lazy var myTagCollectionViewModel: MyTagCollectionViewModel = {
        .init(identifier: UUID().uuidString,
              items: initialItems,
              dimension: .defaultStub,
              alignment: .left)
    }()
    
    private lazy var myTagCollectionView: MyTagCollectionView = {
        .init(viewModel: myTagCollectionViewModel)
        .usingAutolayout()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        view.addSubviews([titleLabel, myTagCollectionView])
        
        setConstraints()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

