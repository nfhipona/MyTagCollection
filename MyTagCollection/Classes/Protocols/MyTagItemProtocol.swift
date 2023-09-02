//
//  MyTagItemProtocol.swift
//  MyTagCollection
//
//  Created by Neil Francis Hipona on 8/6/23.
//

import Foundation

public
protocol MyTagItemProtocol {
    var type: MyTagItemType { get }
    var identifier: String { get }
    var modelView: MyTagBaseItemView.Type { get }
    var model: MyTagItemModelProtocol { get }
    var attribute: MyTagItemAttributeProtocol { get }
    var isSelected: Bool { get set }
}
