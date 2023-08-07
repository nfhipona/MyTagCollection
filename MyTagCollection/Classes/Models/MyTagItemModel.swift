//
//  MyTagItemModel.swift
//  MyTagCollection
//
//  Created by Neil Francis Hipona on 8/7/23.
//

import Foundation

public
struct MyTagItemModel: MyTagItemModelProtocol {
    public let title: String
    public let value: Any
    
    public init(title: String, value: Any) {
        self.title = title
        self.value = value
    }
}
