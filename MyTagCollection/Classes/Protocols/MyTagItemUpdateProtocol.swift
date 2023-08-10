//
//  MyTagItemUpdateProtocol.swift
//  MyTagCollection
//
//  Created by Neil Francis Hipona on 8/10/23.
//

import Foundation

public
protocol MyTagItemUpdateProtocol: NSObjectProtocol {
    func childItem(tagItem: MyTagItemProtocol,
                   tagView: MyTagItemViewProtocol,
                   requestAction action: MyTagItemUpdateAction)
}
