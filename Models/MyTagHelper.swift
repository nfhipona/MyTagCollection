//
//  MyTagHelper.swift
//  MyTagCollection
//
//  Created by Neil Francis Hipona on 8/7/23.
//

import Foundation

public
extension UIView {
    @discardableResult
    func usingAutolayout() -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        return self
    }
    
    func addSubviews(_ views: [UIView]) {
        views.forEach { addSubview($0) }
    }
}

public extension Array {
    func isLastItem(with index: Int) -> Bool {
        return count - 1 == index
    }
}
