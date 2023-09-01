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
    
    public
    override init(frame: CGRect) {
        super.init(frame: frame)
        usingAutolayout()
        setViews()
        setConstraints()
    }
    
    public required
    convenience init(parent: MyTagItemUpdateProtocol,
                     item: MyTagExpandableItemProtocol) {
        self.init(frame: .zero)
        self.parent = parent
        configure(item: item)
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
}
