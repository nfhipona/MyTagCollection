//
//  MyTagBaseExpandableItemViewModel.swift
//  MyTagCollection
//
//  Created by Neil Francis Hipona on 9/1/23.
//

import Foundation

public
struct MyTagBaseExpandableItemViewModel: MyTagExpandableItemProtocol {
    public var modelView: MyTagBaseExpandableItemView.Type {
        MyTagBaseExpandableItemView.self
    }
    
    public var identifier: String
    public var attribute: MyTagExpandableItemAttribute
    
    public
    init(identifier: String,
         attribute: MyTagExpandableItemAttribute) {
        self.identifier = identifier
        self.attribute = attribute
    }
}
