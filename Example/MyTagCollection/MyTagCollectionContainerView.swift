//
//  MyTagCollectionContainerView.swift
//  MyTagCollection_Example
//
//  Created by Neil Francis Hipona on 8/7/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import MyTagCollection

class MyTagCollectionContainerView: UIView {
    var alignment: MyTagSection.Alignment
    private var initialItems: [MyTagItemCustomViewModel]

    private
    lazy var myTagCollectionViewModel: MyTagCollectionViewModel = {
        .init(identifier: UUID().uuidString,
              items: initialItems,
              dimension: .defaultStub,
              alignment: alignment,
              isMultiSelection: false)
    }()
    
    private
    lazy var myTagCollectionView: MyTagCollectionView = {
        .init(viewModel: myTagCollectionViewModel)
        .usingAutolayout()
    }()
    
    override init(frame: CGRect) {
        self.alignment = .center
        self.initialItems = []
        super.init(frame: frame)
        usingAutolayout()
    }
    
    required
    convenience init(alignment: MyTagSection.Alignment,
                     initialItems: [MyTagItemCustomViewModel]) {
        self.init(frame: .zero)
        self.alignment = alignment
        self.initialItems = initialItems
        
        addSubviews([myTagCollectionView])
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            myTagCollectionView.topAnchor.constraint(equalTo: topAnchor),
            myTagCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            myTagCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            myTagCollectionView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor)
        ])
    }
    
    func updateAlignment(alignment: MyTagSection.Alignment) {
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut) { [unowned self] in
            myTagCollectionViewModel.alignment = alignment
        }
    }
    
    func updateSelectionOption(isMultiSelection: Bool) {
        // the after
        myTagCollectionViewModel.isMultiSelection = isMultiSelection
    }
}
