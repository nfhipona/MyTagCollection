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
    
    private let segmentControl: UISegmentedControl = {
        let segmented = UISegmentedControl(items: ["Left Align", "Center Align", "Right Align"])
        segmented.selectedSegmentIndex = 0
        return segmented.usingAutolayout()
    }()
    
    private
    lazy var containerViews: [MyTagCollectionContainerView] = {
        [
            .init(viewIndex: 0,
                  alignment: .left,
                  initialItems: initialItems),
            .init(viewIndex: 1,
                  alignment: .center,
                  initialItems: initialItems),
            .init(viewIndex: 2,
                  alignment: .right,
                  initialItems: initialItems)
        ]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.addSubviews([titleLabel, segmentControl])
        view.addSubviews(containerViews)
        setConstraints()
        setBindings()
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
            
            segmentControl.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            segmentControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            segmentControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        for (idx, containerView) in containerViews.enumerated() {
            containerView.isHidden = idx != 0
            NSLayoutConstraint.activate([
                containerView.topAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: 20),
                containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                containerView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -40),
            ])
        }
    }
    
    private func setBindings() {
        segmentControl.addTarget(self, action: #selector(segmentChange(sender:)), for: .valueChanged)
    }
    
    @objc
    private func segmentChange(sender: UISegmentedControl) {
        print(sender.selectedSegmentIndex)
        
        for containerView in containerViews {
            let isVisible = containerView.viewIndex == sender.selectedSegmentIndex
            containerView.isHidden = !isVisible
        }
    }
}

