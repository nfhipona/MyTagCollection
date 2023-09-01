//
//  MyTagExpandableItemViewProtocol.swift
//  MyTagCollection
//
//  Created by Neil Francis Hipona on 9/1/23.
//

import Foundation

public
protocol MyTagExpandableItemViewProtocol {
    var item: MyTagExpandableItemProtocol? { get }
    var itemCanvas: CGSize { get }
    
    func configure(item: MyTagExpandableItemProtocol)
}
