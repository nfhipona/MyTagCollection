//
//  ExpandedTagItemViewModel.swift
//  MyTagCollection_Example
//
//  Created by Neil Francis Hipona on 8/27/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation
import MyTagCollection

class ExpandedTagItemViewModel: MyTagItemProtocol {
    var modelView: MyTagBaseItemView.Type {
        ExpandedTagItemView.self
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

extension ExpandedTagItemViewModel {
    static var attritube: MyTagItemAttribute {
        .init(topPadding: 11,
              leftPadding: 20,
              rightPadding: 20,
              bottomPadding: 11,
              
              preDefinedConsumedSpace: 0,
              
              titleLabelHeight: 18,
              titleAttributes: [
                .font: UIFont.systemFont(ofSize: 14,
                                         weight: .regular)
              ],
              
              cornerRadius: 20,
              borderWidth: 1.5,
              
              borderColor: .gray,
              backgroundColor: .lightGray,
              selectedBorderColor: .blue,
              selectedBackgroundColor: .cyan,
              
              fixedCanvas: .init(width: UIScreen.main.bounds.width - 40,
                                 height: 200))
    }
}
