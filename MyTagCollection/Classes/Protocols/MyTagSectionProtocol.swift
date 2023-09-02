//
//  MyTagSectionProtocol.swift
//  MyTagCollection
//
//  Created by Neil Francis Hipona on 8/27/23.
//

import Foundation

public
protocol MyTagSectionProtocol {
    typealias Alignment = MyTagSectionAlignment
    
    var section: Int { get }
    var rows: [MyTagItemViewProtocol] { get set }
    var expandedItems: [MyTagExpandableItemViewProtocol] { get set }
    var dimension: MyTagSectionDimension { get }
    var alignment: Alignment { get }
    
    var tallestItemInRow: MyTagItemViewProtocol? { get }
    var totalItemSpacing: CGFloat { get }
    var centerItemPadding: CGFloat { get }    
}
