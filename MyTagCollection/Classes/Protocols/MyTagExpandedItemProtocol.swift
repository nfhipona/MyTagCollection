//
//  MyTagExpandedItemProtocol.swift
//  MyTagCollection
//
//  Created by Neil Francis Hipona on 9/1/23.
//

import Foundation

public
protocol MyTagExpandedItemProtocol {
    var identifier: String { get }
    var modelView: MyTagBaseItemView.Type { get }
    var model: MyTagItemModelProtocol { get }
    var attribute: MyTagItemAttributeProtocol { get }
}
