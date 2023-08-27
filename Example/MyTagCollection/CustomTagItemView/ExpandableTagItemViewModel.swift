//
//  ExpandableTagItemViewModel.swift
//  MyTagCollection_Example
//
//  Created by Neil Francis Hipona on 8/27/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation
import MyTagCollection

struct ExpandableTagItemViewModel: MyTagItemProtocol {
    var modelView: MyTagBaseItemView.Type {
        ExpandableTagItemView.self
    }
    
    let identifier: String
    let model: MyTagItemModelProtocol
    let attribute: MyTagItemAttributeProtocol
    var isSelected: Bool
    
    init(identifier: String,
         model: MyTagItemModelProtocol,
         attribute: MyTagItemAttributeProtocol,
         isSelected: Bool = false) {
        self.identifier = identifier
        self.model = model
        self.attribute = attribute
        self.isSelected = isSelected
    }
}

extension ExpandableTagItemViewModel {
    var expandedItem: ExpandedTagItemViewModel {
        .init(identifier: UUID().uuidString,
              model: ExpandedTagItemModel(id: UUID().uuidString,
                                          title: model.title,
                                          value: "Expanded Item Value"),
              attribute: ExpandedTagItemViewModel.attritube)
    }
}
