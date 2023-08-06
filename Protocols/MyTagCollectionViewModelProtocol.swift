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
    
    var identifier: String { get }
    var isAppendable: Bool { get }
    var items: [MyTagItemProtocol] { get }
    var dimension: MyTagSectionDimension { get }
}
