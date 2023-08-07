//
//  MyTagSectionDimension.swift
//  MyTagCollection
//
//  Created by Neil Francis Hipona on 8/6/23.
//

import Foundation

public
struct MyTagSectionDimension: MyTagSectionDimensionProtocol {
    public let columnSpacing: CGFloat
    public let rowSpacing: CGFloat
    public let contentCanvas: CGSize
    public let inset: UIEdgeInsets
    
    public init(columnSpacing: CGFloat,
                rowSpacing: CGFloat,
                contentCanvas: CGSize,
                inset: UIEdgeInsets) {
        self.columnSpacing = columnSpacing
        self.rowSpacing = rowSpacing
        self.contentCanvas = contentCanvas
        self.inset = inset
    }
}

public
extension MyTagSectionDimension {
    var verticalPadding: CGFloat {
        inset.top + inset.bottom
    }
    
    var horizontalPadding: CGFloat {
        inset.left + inset.right
    }
}

public
extension MyTagSectionDimension {
    static let defaultStub: MyTagSectionDimension = {
        .init(columnSpacing: 12,
              rowSpacing: 12,
              contentCanvas: CGSize(width: UIScreen.main.bounds.width - 40,
                                    height: .greatestFiniteMagnitude),
              inset: .zero)
    }()
}
