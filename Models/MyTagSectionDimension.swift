//
//  MyTagSectionDimension.swift
//  MyTagCollection
//
//  Created by Neil Francis Hipona on 8/6/23.
//

import Foundation

public
struct MyTagSectionDimension: MyTagSectionDimensionProtocol {
    public let interItemSpacing: CGFloat
    public let columnSpacing: CGFloat
    public let rowSpacing: CGFloat
    public let contentCanvas: CGSize
    
    public init(interItemSpacing: CGFloat,
                columnSpacing: CGFloat,
                rowSpacing: CGFloat,
                contentCanvas: CGSize) {
        self.interItemSpacing = interItemSpacing
        self.columnSpacing = columnSpacing
        self.rowSpacing = rowSpacing
        self.contentCanvas = contentCanvas
    }
}

public
extension MyTagSectionDimension {
    static let defaultStub: MyTagSectionDimension = {
        .init(interItemSpacing: 0,
              columnSpacing: 12,
              rowSpacing: 12,
              contentCanvas: CGSize(width: UIScreen.main.bounds.width - 40,
                                    height: .greatestFiniteMagnitude))
    }()
}
