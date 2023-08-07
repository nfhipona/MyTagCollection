//
//  MyTagSection.swift
//  MyTagCollection
//
//  Created by Neil Francis Hipona on 8/6/23.
//

import Foundation

public
struct MyTagSection {
    public let section: Int
    public var rows: [MyTagItemViewProtocol]
    public let dimension: MyTagSectionDimension
    public let alignment: Alignment
    
    public init(section: Int,
                rows: [MyTagItemViewProtocol],
                dimension: MyTagSectionDimension = .defaultStub,
                alignment: Alignment = .center) {
        self.section = section
        self.rows = rows
        self.dimension = dimension
        self.alignment = alignment
    }
}

public
extension MyTagSection {
    enum Alignment {
        case left
        case center
        case right
        
        public var description: String {
            switch self {
            case .left: return "Left Align"
            case .center: return "Center Align"
            case .right: return "Right Align"
            }
        }
    }
}

public
extension MyTagSection {
    var tallestItemInRow: MyTagItemViewProtocol? {
        var tallestItem: MyTagItemViewProtocol? = rows.first
        for rowItem in rows {
            if let item = tallestItem, item.itemCanvas.height < rowItem.itemCanvas.height {
                tallestItem = rowItem
            }
        }
        return tallestItem
    }
    
    var totalItemSpacing: CGFloat {
        return dimension.columnSpacing * CGFloat(rows.count - 1)
    }
    
    var centerItemPadding: CGFloat {
        let totalItemWidth = rows.reduce(CGFloat(0.0)) { partialResult, rowItem in
            partialResult + rowItem.itemCanvas.width
        }
        let contentItemWidth = totalItemWidth + totalItemSpacing
        let contentWidth = dimension.contentCanvas.width - contentItemWidth
        return contentWidth / 2
    }
    
    mutating func append(item: MyTagItemViewProtocol) {
        rows.append(item)
    }
}
