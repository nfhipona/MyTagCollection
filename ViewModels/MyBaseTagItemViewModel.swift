//
//  MyBaseTagItemViewModel.swift
//  MyTagCollection
//
//  Created by Neil Francis Hipona on 8/6/23.
//

import Foundation

public
struct MyBaseTagItemViewModel: MyTagItemProtocol {
    public var modelView: MyBaseTagItemView.Type {
        MyBaseTagItemView.self
    }
    
    public let identifier: String
    public let model: MyTagItemModelProtocol
    public let attribute: MyTagItemAttributeProtocol
    public var section: Int // will be set dynamically upon layout calculations
    public var isSelected: Bool
    
    public
    init(identifier: String,
         model: MyTagItemModelProtocol,
         attribute: MyTagItemAttributeProtocol,
         section: Int = 0,
         isSelected: Bool = false) {
        self.identifier = identifier
        self.model = model
        self.attribute = attribute
        self.section = section
        self.isSelected = isSelected
    }
}

public
extension MyBaseTagItemViewModel {
    func updateSelected(isSelected: Bool) -> MyBaseTagItemViewModel {
        var mutated = self
        mutated.isSelected = isSelected
        return mutated
    }
}
