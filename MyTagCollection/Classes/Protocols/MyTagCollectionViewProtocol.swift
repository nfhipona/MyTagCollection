//
//  MyTagCollectionViewProtocol.swift
//  MyTagCollection
//
//  Created by Neil Francis Hipona on 8/7/23.
//

import Foundation

public
protocol MyTagCollectionViewProtocol {
    var tagSections: [MyTagSection] { get }
    
    init(frame: CGRect,
         viewModel: MyTagCollectionViewModelProtocol)
}
