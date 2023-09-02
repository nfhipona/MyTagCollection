//
//  MyTagSectionAlignment.swift
//  MyTagCollection
//
//  Created by Neil Francis Hipona on 8/27/23.
//

import Foundation

public
enum MyTagSectionAlignment {
    case left
    case center
    case right
    
    public var description: String {
        switch self {
        case .left: return "Left Align"
        case .center: return "Center Align"
        case .right: return "Right Align"
        }
    }
}
