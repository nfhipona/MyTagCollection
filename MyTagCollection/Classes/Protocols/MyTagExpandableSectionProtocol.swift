//
//  MyTagExpandableSectionProtocol.swift
//  MyTagCollection
//
//  Created by Neil Francis Hipona on 9/1/23.
//

import Foundation

public
protocol MyTagExpandableSectionProtocol: MyTagSectionProtocol {
    var expandedItems: [MyTagExpandableItemViewProtocol] { get set }
}
