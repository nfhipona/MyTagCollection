//
//  MyTagBaseSectionProtocol.swift
//  MyTagCollection
//
//  Created by Neil Francis Hipona on 9/1/23.
//

import Foundation

public
protocol MyTagBaseSectionProtocol {
    typealias Alignment = MyTagSectionAlignment
    
    var section: Int { get }
    var rows: [MyTagItemViewProtocol] { get set }
    var dimension: MyTagSectionDimension { get }
    var alignment: Alignment { get }
}
