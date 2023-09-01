//
//  MyTagExpandableItemProtocol.swift
//  MyTagCollection
//
//  Created by Neil Francis Hipona on 9/1/23.
//

import Foundation

public
protocol MyTagExpandableItemProtocol {
    var identifier: String { get }
    var modelView: MyTagBaseExpandableItemView.Type { get }
    var attribute: MyTagExpandableItemAttribute { get }
}
