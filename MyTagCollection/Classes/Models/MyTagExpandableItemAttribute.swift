//
//  MyTagExpandableItemAttribute.swift
//  MyTagCollection
//
//  Created by Neil Francis Hipona on 9/1/23.
//

import Foundation

/// Customization
/// - this is for the item dimension within item canvas
public
struct MyTagExpandableItemAttribute: MyTagExpandableItemAttributeProtocol {
    public let itemCanvas: CGSize
    public let inset: UIEdgeInsets
    
    public init(itemCanvas: CGSize,
                inset: UIEdgeInsets) {
        self.itemCanvas = itemCanvas
        self.inset = inset
    }
}
