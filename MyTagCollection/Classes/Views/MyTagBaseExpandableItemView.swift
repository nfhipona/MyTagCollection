//
//  MyTagBaseExpandableItemView.swift
//  MyTagCollection
//
//  Created by Neil Francis Hipona on 9/1/23.
//

import Foundation

open
class MyTagBaseExpandableItemView: UIView, MyTagExpandableItemViewProtocol {
    public unowned var parent: MyTagItemUpdateProtocol?
    public var section: Int = 0
    public var item: MyTagExpandableItemProtocol?
    public var itemCanvas: CGSize = .zero
    
    public
    override init(frame: CGRect) {
        super.init(frame: frame)
        usingAutolayout()
        setViews()
        setConstraints()
    }
    
    public required
    convenience init(parent: MyTagItemUpdateProtocol,
                     item: MyTagExpandableItemProtocol,
                     dimension: MyTagSectionDimensionProtocol) {
        self.init(frame: .zero)
        self.parent = parent
        configure(item: item)
        self.itemCanvas = sizeInCanvas(dimension: dimension)
    }
    
    public
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func setViews() {}
    open func setConstraints() {}
    
    open func configure(item: MyTagExpandableItemProtocol) {
        self.item = item
    }
    
    private func sizeInCanvas(dimension: MyTagSectionDimensionProtocol) -> CGSize {
        guard let item,
              let attribute = item.attribute as? MyTagExpandableItemAttribute
        else { return .zero }
        
        let sidePadding = attribute.inset.left + attribute.inset.right
        let contentItemWidth = attribute.itemCanvas.width + sidePadding
        
        if contentItemWidth > dimension.contentCanvas.width {
            let calculatedWidth = dimension.contentCanvas.width - sidePadding
            return CGSize(width: calculatedWidth,
                          height: attribute.itemCanvas.height)
        }
        
        return attribute.itemCanvas
    }
}
