//
//  MyTagCollectionViewModelProtocol.swift
//  MyTagCollection
//
//  Created by Neil Francis Hipona on 8/7/23.
//

import Foundation

public
protocol MyTagCollectionViewModelProtocol {
    typealias Alignment = MyTagSection.Alignment
    
    var identifier: String { get }
    var items: [MyTagItemProtocol] { get }
    var dimension: MyTagSectionDimension { get }
    var alignment: Alignment { get set }
    var isAppendable: Bool { get set }
    var isMultiSelection: Bool { get set }
    var isExpandable: Bool { get }
    var viewDelegate: MyTagCollectionUpdateProtocol? { get set }
    
    init(identifier: String,
         items: [MyTagItemProtocol],
         dimension: MyTagSectionDimension,
         alignment: Alignment,
         isAppendable: Bool,
         isMultiSelection: Bool,
         isExpandable: Bool)
}
