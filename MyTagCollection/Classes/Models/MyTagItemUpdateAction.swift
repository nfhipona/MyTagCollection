//
//  MyTagItemUpdateAction.swift
//  MyTagCollection
//
//  Created by Neil Francis Hipona on 8/10/23.
//

import Foundation

public
enum MyTagItemUpdateAction {
    case isSelected(state: Bool)
    case remove
    case expandWith(expandedItem: MyTagExpandableItemProtocol)
    case collapse
}
