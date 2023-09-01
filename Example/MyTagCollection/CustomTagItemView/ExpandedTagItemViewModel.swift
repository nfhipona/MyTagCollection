//
//  ExpandedTagItemViewModel.swift
//  MyTagCollection_Example
//
//  Created by Neil Francis Hipona on 8/27/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation
import MyTagCollection

struct ExpandedTagItemViewModel: MyTagExpandableItemProtocol {
    var modelView: MyTagBaseExpandableItemView.Type {
        ExpandedTagItemView.self
    }
    
    let identifier: String
    let model: MyTagItemModelProtocol
    let attribute: MyTagExpandableItemAttributeProtocol
    
    init(identifier: String,
         model: MyTagItemModelProtocol,
         attribute: MyTagExpandableItemAttributeProtocol) {
        self.identifier = identifier
        self.model = model
        self.attribute = attribute
    }
}
