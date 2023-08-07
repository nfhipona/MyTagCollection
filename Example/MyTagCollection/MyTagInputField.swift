//
//  MyTagInputField.swift
//  MyTagCollection_Example
//
//  Created by Neil Francis Hipona on 8/7/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

class MyTagInputField: UITextField {
    let textPadding = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let textRect = super.textRect(forBounds: bounds)
        return textRect.insetBy(dx: textPadding.left,
                                dy: textPadding.bottom)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let textRect = super.editingRect(forBounds: bounds)
        return textRect.insetBy(dx: textPadding.left,
                                dy: textPadding.bottom)
    }
    
    func cleanText() -> String {
        let str = text ?? ""
        return str.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
