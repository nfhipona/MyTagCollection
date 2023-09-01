//
//  MyTagExpandableSection.swift
//  MyTagCollection
//
//  Created by Neil Francis Hipona on 8/27/23.
//

import Foundation

public
struct MyTagExpandableSection: MyTagExpandableSectionProtocol {
    public let section: Int
    public var rows: [MyTagItemViewProtocol]
    public var expandedItems: [MyTagExpandableItemViewProtocol]
    public let dimension: MyTagSectionDimension
    public let alignment: Alignment
    
    public init(section: Int,
                rows: [MyTagItemViewProtocol],
                expandedItems: [MyTagExpandableItemViewProtocol] = [],
                dimension: MyTagSectionDimension = .defaultStub,
                alignment: Alignment = .center) {
        self.section = section
        self.rows = rows
        self.expandedItems = expandedItems
        self.dimension = dimension
        self.alignment = alignment
    }
}

public
extension MyTagExpandableSection {
    var tallestItemInRow: MyTagItemViewProtocol? { nil }
    var totalItemSpacing: CGFloat { 0 }
    
    var centerItemPadding: CGFloat {
        let totalItemWidth = rows.reduce(CGFloat(0.0)) { partialResult, rowItem in
            partialResult + rowItem.itemCanvas.width
        }
        let contentItemWidth = totalItemWidth + totalItemSpacing
        let contentWidth = dimension.contentCanvas.width - contentItemWidth
        return contentWidth / 2
    }
    
    @discardableResult
    mutating func append(item: MyTagItemViewProtocol) -> Self {
        rows.append(item)
        return self
    }
    
    @discardableResult
    mutating func append(expanedItem: MyTagExpandableItemViewProtocol) -> Self {
        expandedItems.append(expanedItem)
        return self
    }
    
    @discardableResult
    mutating func resetExpandedItems() -> Self {
        expandedItems = []
        return self
    }
}
