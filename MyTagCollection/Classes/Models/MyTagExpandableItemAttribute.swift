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
    public let contentCanvas: CGSize
    public let inset: UIEdgeInsets
    
    public init(contentCanvas: CGSize,
                inset: UIEdgeInsets) {
        self.contentCanvas = contentCanvas
        self.inset = inset
    }
}
