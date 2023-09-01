//
//  MyTagExpandedItemViewProtocol.swift
//  MyTagCollection
//
//  Created by Neil Francis Hipona on 9/1/23.
//

import Foundation

public
protocol MyTagExpandedItemViewProtocol {
    var item: MyTagExpandedItemProtocol? { get }
    var itemCanvas: CGSize { get }
    
    @discardableResult
    func sizeInCanvas(dimension: MyTagSectionDimensionProtocol) -> CGSize
    func configure(item: MyTagItemProtocol)
}
