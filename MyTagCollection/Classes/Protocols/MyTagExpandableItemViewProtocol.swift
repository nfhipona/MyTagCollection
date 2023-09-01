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
    
    func configure(item: MyTagExpandableItemProtocol)
}
