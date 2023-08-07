//
//  MyTagItemAttribute.swift
//  MyTagCollection
//
//  Created by Neil Francis Hipona on 8/6/23.
//

import Foundation

/// Customization
/// - this is for the item dimension within item canvas
public
struct MyTagItemAttribute: MyTagItemAttributeProtocol {
    public let topPadding: CGFloat
    public let leftPadding: CGFloat
    public let rightPadding: CGFloat
    public let bottomPadding: CGFloat
    
    /// Pre-defined |-hp- LABEL -hp-| -- |-hp- LABEL + -item-padding- + FIXED-ITEM-WIDTH -hp-|
    public let preDefinedConsumedSpace: CGFloat
    
    /// Min height
    public let titleLabelHeight: CGFloat
    public let titleAttributes: [NSAttributedString.Key: Any]
    
    public let cornerRadius: CGFloat
    public let borderWidth: CGFloat
    
    public let borderColor: UIColor
    public let backgroundColor: UIColor
    public let selectedBorderColor: UIColor
    public let selectedBackgroundColor: UIColor
    
    public let fixedCanvas: CGSize?
    
    public init(topPadding: CGFloat,
                leftPadding: CGFloat,
                rightPadding: CGFloat,
                bottomPadding: CGFloat,
                preDefinedConsumedSpace: CGFloat,
                titleLabelHeight: CGFloat,
                titleAttributes: [NSAttributedString.Key: Any],
                cornerRadius: CGFloat,
                borderWidth: CGFloat,
                borderColor: UIColor,
                backgroundColor: UIColor,
                selectedBorderColor: UIColor,
                selectedBackgroundColor: UIColor,
                fixedCanvas: CGSize?) {
        self.topPadding = topPadding
        self.leftPadding = leftPadding
        self.rightPadding = rightPadding
        self.bottomPadding = bottomPadding
        
        self.preDefinedConsumedSpace = preDefinedConsumedSpace
        
        self.titleLabelHeight = titleLabelHeight
        self.titleAttributes = titleAttributes
        
        self.cornerRadius = cornerRadius
        self.borderWidth = borderWidth
        
        self.borderColor = borderColor
        self.backgroundColor = backgroundColor
        self.selectedBorderColor = selectedBorderColor
        self.selectedBackgroundColor = selectedBackgroundColor
        
        self.fixedCanvas = fixedCanvas
    }
}

public
extension MyTagItemAttribute {
    static let defaultStub: MyTagItemAttribute = {
        .init(topPadding: 11,
              leftPadding: 20,
              rightPadding: 20,
              bottomPadding: 11,
              
              preDefinedConsumedSpace: 0,
              
              titleLabelHeight: 18,
              titleAttributes: [
                .font: UIFont.systemFont(ofSize: 14,
                                         weight: .regular)
              ],
              
              cornerRadius: 20,
              borderWidth: 1.5,
              
              borderColor: .gray,
              backgroundColor: .lightGray,
              selectedBorderColor: .blue,
              selectedBackgroundColor: .cyan,
              
              fixedCanvas: nil)
    }()
}
