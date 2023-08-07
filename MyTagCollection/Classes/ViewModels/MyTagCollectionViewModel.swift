//
//  MyTagCollectionViewModel.swift
//  MyTagCollection
//
//  Created by Neil Francis Hipona on 8/7/23.
//

import Foundation

public
class MyTagCollectionViewModel: MyTagCollectionViewModelProtocol {
    public let identifier: String
    public var items: [MyTagItemProtocol]
    public let dimension: MyTagSectionDimension
    public let alignment: Alignment
    public var isAppendable: Bool

    public init(identifier: String,
                items: [MyTagItemProtocol],
                dimension: MyTagSectionDimension,
                alignment: Alignment,
                isAppendable: Bool = true) {
        self.identifier = identifier
        self.items = items
        self.dimension = dimension
        self.alignment = alignment
        self.isAppendable = isAppendable
    }
}

public
extension MyTagCollectionViewModel {
    enum ItemPosition {
        case first
        case last
        case byIndex(index: Int)
    }
}

public
extension MyTagCollectionViewModel {
    func appendItem(tagItem: MyTagItemProtocol, position: ItemPosition) {
        guard isAppendable else { return }
        switch position {
        case .first:
            items.insert(tagItem, at: 0)
            
        case let .byIndex(index):
            items.insert(tagItem, at: index)
            
        default: // last
            items.append(tagItem)
        }
    }
    
    func setItems(tagItems: [MyTagItemProtocol]) {
        items = tagItems
    }
    
    func addItem(tagItem: MyTagItemProtocol,
                 position: ItemPosition,
                 replaceOld: Bool) {
        if replaceOld {
            removeItem(tagItem: tagItem)
        }
        
        appendItem(tagItem: tagItem, position: position)
    }
    
    func addItems(tagItems: [MyTagItemProtocol],
                  position: ItemPosition,
                  replaceOld: Bool) {
        if replaceOld {
            removeItems(tagItems: tagItems)
        }
        
        for tagItem in tagItems {
            appendItem(tagItem: tagItem, position: position)
        }
    }
    
    func updateItem(isMultiple: Bool,
                    tagItem: MyTagItemProtocol,
                    isSelected: Bool) {
        items = items.map({ item in
            if isMultiple {
                if item.identifier == tagItem.identifier {
                    var mutatedItem = item
                    mutatedItem.isSelected = isSelected
                    return mutatedItem
                }
            } else {
                let isSelected = item.identifier == tagItem.identifier ? isSelected : false
                var mutatedItem = item
                mutatedItem.isSelected = isSelected
                return mutatedItem
            }
            return item
        })
    }
    
    func removeItem(tagItem: MyTagItemProtocol) {
        items.removeAll { $0.identifier == tagItem.identifier }
    }

    func removeItems(tagItems: [MyTagItemProtocol]) {
        items.removeAll {
            for tagItem in tagItems where $0.identifier == tagItem.identifier {
                return true
            }
            return false
        }
    }
}
