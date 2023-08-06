//
//  MyTagItemAttributeProtocol.swift
//  MyTagCollection
//
//  Created by Neil Francis Hipona on 8/6/23.
//

import Foundation

public
protocol MyTagItemAttributeProtocol {
    var topPadding: CGFloat { get }
    var leftPadding: CGFloat { get }
    var rightPadding: CGFloat { get }
    var bottomPadding: CGFloat { get }
    
    var preDefinedConsumedSpace: CGFloat { get }
    
    /// Min height
    var titleLabelHeight: CGFloat { get }
    var titleAttributes: [NSAttributedString.Key: Any] { get }
}
