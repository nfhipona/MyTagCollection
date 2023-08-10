//
//  MyTagCollectionViewModelProtocol.swift
//  MyTagCollection
//
//  Created by Neil Francis Hipona on 8/7/23.
//

import Foundation

public
protocol MyTagCollectionViewModelProtocol {
    typealias ItemPosition = MyTagCollectionViewModel.ItemPosition
    typealias Alignment = MyTagSection.Alignment
    
    var identifier: String { get }
    var items: [MyTagItemProtocol] { get }
    var dimension: MyTagSectionDimension { get }
    var alignment: Alignment { get }
    var isAppendable: Bool { get }
    var isMultiSelection: Bool { get }
    
    init(identifier: String,
         items: [MyTagItemProtocol],
         dimension: MyTagSectionDimension,
         alignment: Alignment,
         isAppendable: Bool,
         isMultiSelection: Bool)
}
