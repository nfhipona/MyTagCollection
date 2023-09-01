//
//  MyTagSectionProtocol.swift
//  MyTagCollection
//
//  Created by Neil Francis Hipona on 8/27/23.
//

import Foundation

public
protocol MyTagSectionProtocol: MyTagBaseSectionProtocol {
    var tallestItemInRow: MyTagItemViewProtocol? { get }
    var totalItemSpacing: CGFloat { get }
    var centerItemPadding: CGFloat { get }    
}
