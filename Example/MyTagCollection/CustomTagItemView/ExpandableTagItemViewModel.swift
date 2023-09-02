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
    public var type: MyTagItemType = .expandable
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
              attribute: MyTagExpandableItemAttribute(itemCanvas: .init(width: UIScreen.main.bounds.size.width - 80,
                                                                           height: 200),
                                                      inset: .init(top: 11,
                                                                   left: 0,
                                                                   bottom: 11,
                                                                   right: 0)))
    }
}
