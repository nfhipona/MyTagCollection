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
    private var isMultiSelection: Bool
    private var initialItems: [MyTagItemProtocol]
    
    private
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "\(selectionOptionDescription) - \(alignment.description)"
        label.font = UIFont.systemFont(ofSize: 20,
                                       weight: .bold)
        return label.usingAutolayout()
    }()
    
    private let inputTextField: MyTagInputField = {
        let textField = MyTagInputField()
        textField.placeholder = "Add Tag"
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 8
        return textField.usingAutolayout()
    }()
    
    private let addButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "plus"), for: .normal)
        button.clipsToBounds = true
        return button.usingAutolayout()
    }()
    
    private
    lazy var myTagCollectionViewModel: MyTagCollectionViewModel = {
        .init(identifier: UUID().uuidString,
              items: initialItems,
              dimension: .defaultStub,
              alignment: alignment,
              isMultiSelection: isMultiSelection)
    }()
    
    private
    lazy var myTagCollectionView: MyTagCollectionView = {
        .init(viewModel: myTagCollectionViewModel)
        .usingAutolayout()
    }()
    
    private
    let myTagCollectionViewContainerView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView.usingAutolayout()
    }()
    
    private var selectionOptionDescription: String {
        isMultiSelection ? "Multi Selection" : "Single Selection"
    }
    
    init(alignment: MyTagSection.Alignment,
         isMultiSelection: Bool,
         initialItems: [MyTagItemProtocol]) {
        self.alignment = alignment
        self.isMultiSelection = isMultiSelection
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
        
        myTagCollectionViewContainerView.addSubview(myTagCollectionView)
        view.addSubviews([
            titleLabel,
            inputTextField,
            addButton,
            myTagCollectionViewContainerView
        ])
        setConstraints()
        setBindings()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 30),
            
            inputTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            inputTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            inputTextField.trailingAnchor.constraint(equalTo: addButton.leadingAnchor, constant: -8),
            inputTextField.heightAnchor.constraint(equalToConstant: 40),
            
            addButton.centerYAnchor.constraint(equalTo: inputTextField.centerYAnchor),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            addButton.widthAnchor.constraint(equalToConstant: 40),
            addButton.heightAnchor.constraint(equalToConstant: 40),
            
            myTagCollectionViewContainerView.topAnchor.constraint(equalTo: inputTextField.bottomAnchor, constant: 40),
            myTagCollectionViewContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            myTagCollectionViewContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            myTagCollectionViewContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            
            myTagCollectionView.topAnchor.constraint(equalTo: myTagCollectionViewContainerView.topAnchor),
            myTagCollectionView.leadingAnchor.constraint(equalTo: myTagCollectionViewContainerView.leadingAnchor),
            myTagCollectionView.trailingAnchor.constraint(equalTo: myTagCollectionViewContainerView.trailingAnchor),
            myTagCollectionView.bottomAnchor.constraint(equalTo: myTagCollectionViewContainerView.bottomAnchor),
            myTagCollectionView.centerXAnchor.constraint(equalTo: myTagCollectionViewContainerView.centerXAnchor)
        ])
    }
    
    private func setBindings() {
        addButton.addTarget(self, action: #selector(addTagAction), for: .touchUpInside)
    }
    
    @objc
    private func addTagAction() {
        guard inputTextField.cleanText().count > 0 else { return }
        myTagCollectionViewModel.addItem(
            tagItem: MyTagItemLabelRemovableViewModel(identifier: UUID().uuidString,
                                                       model: MyTagItemModel(title: inputTextField.cleanText(),
                                                                             value: inputTextField.cleanText()),
                                                       attribute: MyTagCollectionViewController.removableViewStub),
            position: .last,
            replaceOld: true)
        inputTextField.text = nil
    }
}

extension MyTagCollectionViewController {
    static var removableViewStub: MyTagItemAttribute {
        .init(topPadding: 11,
              leftPadding: 20,
              rightPadding: 8,
              bottomPadding: 11,
              
              preDefinedConsumedSpace: 38, /* calculated space for | label padding | remove icon/button | padding 8 |*/
              
              titleLabelHeight: 18,
              titleAttributes: [
                .font: UIFont.systemFont(ofSize: 14,
                                         weight: .regular)
              ],
              
              cornerRadius: 20,
              borderWidth: 1.5,
              
              borderColor: .gray,
              backgroundColor: .lightGray)
    }
    
}
