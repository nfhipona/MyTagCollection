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
    
    private let proceedButton: UIButton = {
        let button = UIButton()
        button.setTitle("Proceed to Sample", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16,
                                                    weight: .semibold)
        button.backgroundColor = .blue
        button.clipsToBounds = true
        return button.usingAutolayout()
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
    
    private let selectionControlLabel: UILabel = {
        let label = UILabel()
        label.text = "Set Selection Option:"
        label.font = UIFont.systemFont(ofSize: 12,
                                       weight: .bold)
        return label.usingAutolayout()
    }()
    
    private let selectionControl: UISegmentedControl = {
        let segmented = UISegmentedControl(items: ["Single Selection", "Multi Selection"])
        segmented.selectedSegmentIndex = 0
        return segmented.usingAutolayout()
    }()
    
    private let alignmentControlLabel: UILabel = {
        let label = UILabel()
        label.text = "Set Alignment:"
        label.font = UIFont.systemFont(ofSize: 12,
                                       weight: .bold)
        return label.usingAutolayout()
    }()
    
    private let alignmentControl: UISegmentedControl = {
        let segmented = UISegmentedControl(items: ["Left Align", "Center Align", "Right Align"])
        segmented.selectedSegmentIndex = 0
        return segmented.usingAutolayout()
    }()
    
    private
    lazy var containerView: MyTagCollectionContainerView = {
        .init(alignment: .left,
              initialItems: initialItems)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.addSubviews([
            titleLabel,
            selectionControlLabel,
            selectionControl,
            alignmentControlLabel,
            alignmentControl,
            containerView,
            proceedButton])
        setConstraints()
        setBindings()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        proceedButton.layer.cornerRadius = proceedButton.frame.height / 2
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 30),
            
            selectionControlLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            selectionControlLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            selectionControlLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            selectionControl.topAnchor.constraint(equalTo: selectionControlLabel.bottomAnchor, constant: 8),
            selectionControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            selectionControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            alignmentControlLabel.topAnchor.constraint(equalTo: selectionControl.bottomAnchor, constant: 15),
            alignmentControlLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            alignmentControlLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            alignmentControl.topAnchor.constraint(equalTo: alignmentControlLabel.bottomAnchor, constant: 8),
            alignmentControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            alignmentControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            containerView.topAnchor.constraint(equalTo: alignmentControl.bottomAnchor, constant: 20),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            containerView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -100),
            
            proceedButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            proceedButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            proceedButton.widthAnchor.constraint(equalToConstant: 250),
            proceedButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setBindings() {
        selectionControl.addTarget(self, action: #selector(segmentChange(sender:)), for: .valueChanged)
        alignmentControl.addTarget(self, action: #selector(segmentChange(sender:)), for: .valueChanged)
        proceedButton.addTarget(self, action: #selector(proceedButtonAction(sender:)), for: .touchUpInside)
    }
    
    private func selectedAlignment() -> MyTagSection.Alignment {
        switch alignmentControl.selectedSegmentIndex {
        case 1: return .center
        case 2: return .right
        default: return .left
        }
    }
    
    private func selectionOption() -> Bool {
        switch selectionControl.selectedSegmentIndex {
        case 0: return false
        default: return true
        }
    }
    
    @objc
    private func segmentChange(sender: UISegmentedControl) {
        if sender == selectionControl {
            containerView.updateSelectionOption(isMultiSelection: selectionOption())
        } else if sender == alignmentControl {
            containerView.updateAlignment(alignment: selectedAlignment())
        }
    }
    
    @objc
    private func proceedButtonAction(sender: UIButton) {
        let viewController = MyTagCollectionViewController(alignment: selectedAlignment(),
                                                           isMultiSelection: selectionOption(),
                                                           initialItems: initialItems)
        navigationController?.pushViewController(viewController, animated: true)
    }
}

