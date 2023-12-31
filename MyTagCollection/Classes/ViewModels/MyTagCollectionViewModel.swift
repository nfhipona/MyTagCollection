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
    public var alignment: Alignment {
        didSet {
            reloadTags(action: .reloadAndReset)
        }
    }
    public var isAppendable: Bool
    public var isMultiSelection: Bool
    public let isExpandable: Bool
    
    unowned
    public var viewDelegate: MyTagCollectionUpdateProtocol?
    
    public
    required init(identifier: String,
                  items: [MyTagItemProtocol],
                  dimension: MyTagSectionDimension,
                  alignment: Alignment,
                  isAppendable: Bool = true,
                  isMultiSelection: Bool = true,
                  isExpandable: Bool = false) {
        self.identifier = identifier
        self.items = items
        self.dimension = dimension
        self.alignment = alignment
        self.isAppendable = isAppendable
        self.isMultiSelection = isMultiSelection
        self.isExpandable = isExpandable
    }
}

internal
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
    
    func updateItem(with mutatedItem: MyTagItemProtocol) {
        items = items.map({ item in
            if item.identifier == mutatedItem.identifier {
                return mutatedItem
            }
            
            if isMultiSelection {
                return item
            } else {
                var mutatedItem = item
                mutatedItem.isSelected = false
                return mutatedItem
            }
        })
    }
    
    func resetExpandedItems(in collection: [MyTagItemProtocol]) {
        items = items.map({ item in
            for element in collection where element.identifier == item.identifier {
                var mutatedItem = item
                mutatedItem.isSelected = false
                return mutatedItem
            }
            return item
        })
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
    func setItems(tagItems: [MyTagItemProtocol]) {
        items = tagItems
        reloadTags()
    }
    
    func addItem(tagItem: MyTagItemProtocol,
                 position: ItemPosition,
                 replaceOld: Bool) {
        defer { reloadTags() }
        
        if replaceOld {
            removeItem(tagItem: tagItem)
        }
        
        appendItem(tagItem: tagItem, position: position)
    }
    
    func addItems(tagItems: [MyTagItemProtocol],
                  position: ItemPosition,
                  replaceOld: Bool) {
        defer { reloadTags() }
        
        if replaceOld {
            removeItems(tagItems: tagItems)
        }
        
        for tagItem in tagItems {
            appendItem(tagItem: tagItem, position: position)
        }
    }
    
    func removeItem(tagItem: MyTagItemProtocol) {
        items.removeAll { $0.identifier == tagItem.identifier }
        reloadTags()
    }
    
    func removeItems(tagItems: [MyTagItemProtocol]) {
        defer { reloadTags() }
        items.removeAll {
            for tagItem in tagItems where $0.identifier == tagItem.identifier {
                return true
            }
            return false
        }
    }
    
    func resetItems() {
        items = items.map({ item in
            var mutatedItem = item
            mutatedItem.isSelected = false
            return mutatedItem
        })
    }
    
    func reloadTags(action: MyTagCollectionUpdateAction = .reload) {
        guard let viewDelegate else { return }
        viewDelegate.viewModel(viewModel: self,
                               requestAction: action)
    }
}
