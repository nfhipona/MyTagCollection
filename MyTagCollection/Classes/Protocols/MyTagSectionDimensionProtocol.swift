//
//  MyTagSectionDimensionProtocol.swift
//  MyTagCollection
//
//  Created by Neil Francis Hipona on 8/6/23.
//

import Foundation

public
protocol MyTagSectionDimensionProtocol {
    var columnSpacing: CGFloat { get }
    var rowSpacing: CGFloat { get }
    var contentCanvas: CGSize { get }
    var inset: UIEdgeInsets { get }
    
    var verticalPadding: CGFloat { get }
    var horizontalPadding: CGFloat { get }
}
