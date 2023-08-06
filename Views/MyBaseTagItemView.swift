//
//  MyBaseTagItemView.swift
//  MyTagCollection
//
//  Created by Neil Francis Hipona on 8/6/23.
//

import Foundation

public
class MyBaseTagItemView: UIView, MyTagItemViewProtocol {
    public var item: MyTagItemProtocol?
    public var itemCanvas: CGSize = .zero
    
    override
    init(frame: CGRect) {
        super.init(frame: frame)
        
        setViews()
        setConstraints()
    }
    
    required convenience
    public init(frame: CGRect = .zero,
                     item: MyTagItemProtocol,
                     dimension: MyTagSectionDimensionProtocol) {
        self.init(frame: frame)
        
        configure(item: item)
        sizeInCanvas(dimension: dimension)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setViewAttributes()
    }
    
    @discardableResult
    public func sizeInCanvas(dimension: MyTagSectionDimensionProtocol) -> CGSize {
        guard let item,
              let attribute = item.attribute as? MyTagItemAttribute
        else { return .zero }
        
        if let fixedCanvas = attribute.fixedCanvas {
            itemCanvas = fixedCanvas
            return fixedCanvas
        } else {
            let horizontalPadding = attribute.leftPadding + attribute.rightPadding
            let verticalPadding = attribute.topPadding + attribute.bottomPadding
            let sidePadding = dimension.columnSpacing * 2
            
            let fixedItemWidth = attribute.preDefinedConsumedSpace + horizontalPadding
            let allowedTextWidth = dimension.contentCanvas.width - (fixedItemWidth + sidePadding)
            let itemDefaultHeight = verticalPadding + attribute.titleLabelHeight
            
            let textSize = boundingSize(for: item.model.title,
                                        canvas: CGSize(width: allowedTextWidth,
                                                       height: dimension.contentCanvas.height))
            
            let itemCanvasWidth = ceil(textSize.width) + fixedItemWidth
            let canvasHeight = ceil(textSize.height) + verticalPadding
            let itemCanvasHeight = canvasHeight < itemDefaultHeight ? itemDefaultHeight : canvasHeight
            itemCanvas = CGSize(width: itemCanvasWidth, height: itemCanvasHeight)
            
            return itemCanvas
        }
    }
    
    public func shouldDrawInNewRow(itemsInRow: [MyTagItemViewProtocol],
                                   dimension: MyTagSectionDimensionProtocol) -> Bool {
        var rowItemWidth = itemsInRow.reduce(into: CGFloat(0.0)) { partialResult, tagItem in
            partialResult += tagItem.itemCanvas.width
        }
        
        let interItemSpacing = dimension.interItemSpacing * CGFloat(itemsInRow.count)
        let sidePadding = dimension.columnSpacing * 2
        rowItemWidth += interItemSpacing
        rowItemWidth += sidePadding
        rowItemWidth += itemCanvas.width
        
        return rowItemWidth > dimension.contentCanvas.width
    }
    
    public func setViews() {}
    public func setConstraints() {}
    
    public func configure(item: MyTagItemProtocol) {
        defer {
            setViewAttributes()
        }
        
        self.item = item
    }
}

private
extension MyBaseTagItemView {
    func setViewAttributes() {
        if let item, let attribute = item.attribute as? MyTagItemAttribute {
            layer.cornerRadius = attribute.cornerRadius
            layer.borderWidth = attribute.borderWidth
            
            if item.isSelected {
                layer.borderColor = attribute.selectedBorderColor.cgColor
                backgroundColor = attribute.selectedBackgroundColor
            } else {
                layer.borderColor = attribute.borderColor.cgColor
                backgroundColor = attribute.backgroundColor
            }
        }
    }
}

public
extension MyBaseTagItemView {
    func boundingSize(for str: String,
                      canvas: CGSize,
                      options: NSStringDrawingOptions = [.usesLineFragmentOrigin, .usesFontLeading],
                      attributes: [NSAttributedString.Key: Any]? = nil,
                      context: NSStringDrawingContext? = nil) -> CGSize {
        let rect = (str as NSString)
            .boundingRect(with: canvas,
                          options: options,
                          attributes: attributes,
                          context: context)
        return rect.size
    }
}
