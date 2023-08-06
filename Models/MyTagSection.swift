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
    public let rows: [MyTagItemViewProtocol]
    public let dimension: MyTagSectionDimension
    public let alignment: Alignment
    
    public init(section: Int,
                rows: [MyTagItemViewProtocol] = [],
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
    }
}
