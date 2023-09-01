//
//  MyTagItemCustomRemovableViewModel.swift
//  MyTagCollection
//
//  Created by Neil Francis Hipona on 8/10/23.
//

import Foundation

public
struct MyTagItemCustomRemovableViewModel: MyTagItemProtocol {
    public var modelView: MyTagBaseItemView.Type {
        MyTagItemCustomRemovableView.self
    }
    
    public let identifier: String
    public let model: MyTagItemModelProtocol
    public let attribute: MyTagItemAttributeProtocol
    public var isSelected: Bool
    
    public
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