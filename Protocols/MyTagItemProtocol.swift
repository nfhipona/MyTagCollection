//
//  MyTagItemProtocol.swift
//  MyTagCollection
//
//  Created by Neil Francis Hipona on 8/6/23.
//

import Foundation

public
protocol MyTagItemProtocol {
    var identifier: String { get }
    var modelView: MyBaseTagItemView.Type { get }
    var model: MyTagItemModelProtocol { get }
    var attribute: MyTagItemAttributeProtocol { get }
    var section: Int { get set }
    var isSelected: Bool { get set }
    
    func updateSelected(isSelected: Bool) -> Self
}
