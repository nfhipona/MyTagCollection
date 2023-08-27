//
//  MyTagItemViewProtocol.swift
//  MyTagCollection
//
//  Created by Neil Francis Hipona on 8/6/23.
//

import Foundation

public
protocol MyTagItemViewProtocol {
    var section: Int { get set }
    var item: MyTagItemProtocol? { get }
    var itemCanvas: CGSize { get }
    
    init(parent: MyTagItemUpdateProtocol,
         item: MyTagItemProtocol,
         dimension: MyTagSectionDimensionProtocol)
    
    @discardableResult
    func sizeInCanvas(dimension: MyTagSectionDimensionProtocol) -> CGSize
    func shouldDrawInNewRow(itemsInRow: [MyTagItemViewProtocol],
                            dimension: MyTagSectionDimensionProtocol) -> Bool
    func configure(item: MyTagItemProtocol)
}
