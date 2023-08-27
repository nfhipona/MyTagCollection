//
//  MyTagCollectionView.swift
//  MyTagCollection
//
//  Created by Neil Francis Hipona on 8/6/23.
//

import Foundation

public
class MyTagCollectionView: UIView, MyTagCollectionViewProtocol {
    public var viewModel: MyTagCollectionViewModel?
    public var tagSections: [MyTagSectionProtocol] = []
    
    override
    init(frame: CGRect) {
        super.init(frame: frame)
        usingAutolayout()
    }
    
    public required
    convenience init(frame: CGRect = .zero,
                     viewModel: MyTagCollectionViewModelProtocol) {
        self.init(frame: frame)
        configure(viewModel: viewModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private
extension MyTagCollectionView {
    func prepareContentView() {
        tagSections = []
        for view in subviews {
            view.removeFromSuperview()
        }
    }
    
    func addRowItem(toSection: MyTagSectionProtocol,
                    tagItem: MyTagItemViewProtocol) {
        tagSections = tagSections.map { tagSection in
            if tagSection.section == toSection.section {
                var rows = toSection.rows
                rows.append(tagItem)
                return MyTagSection(section: tagSection.section,
                                    rows: rows,
                                    dimension: tagSection.dimension,
                                    alignment: tagSection.alignment)
            } else {
                return tagSection
            }
        }
    }
    
    func addExpandedItem(item: MyTagItemProtocol,
                         referenceSection section: Int) {
        guard let viewModel else { return }
        let dimension = viewModel.dimension
        
        let tagItemView = item.modelView.init(parent: self,
                                              item: item,
                                              dimension: dimension)
            .usingAutolayout()
        
        let tagSection = MyTagExpandedSection(section: section,
                                              rows: [tagItemView],
                                              dimension: dimension,
                                              alignment: viewModel.alignment)
        drawExpandedTag(tagSection: tagSection,
                        referenceSection: section)
        tagSections.insert(tagSection, at: section)
    }
    
    func removeExpandedItem() {
        tagSections = tagSections.filter({ section in
            if let expandedSection = section as? MyTagExpandedSection {
                if let tagView = expandedSection.rows.first as? MyTagBaseItemView {
                    tagView.removeFromSuperview()
                }
                return false
            }
            return true
        })
    }
    
    func prepareTags(items: [MyTagItemProtocol]) {
        prepareContentView()
        guard let viewModel else { return }
        let dimension = viewModel.dimension
        
        for item in items {
            let tagItemView = item.modelView.init(parent: self,
                                                  item: item,
                                                  dimension: dimension)
                .usingAutolayout()
            
            if tagSections.isEmpty {
                let tagSection = MyTagSection(section: 0,
                                              rows: [tagItemView],
                                              dimension: dimension,
                                              alignment: viewModel.alignment)
                tagSections.append(tagSection)
                
            } else if let tagSection = tagSections.last {
                if tagItemView.shouldDrawInNewRow(itemsInRow: tagSection.rows,
                                                  dimension: tagSection.dimension) {
                    let sectionIndex = tagSection.section + 1
                    tagItemView.section = sectionIndex
                    let newTagSection = MyTagSection(section: tagSection.section + 1,
                                                     rows: [tagItemView],
                                                     dimension: dimension,
                                                     alignment: viewModel.alignment)
                    tagSections.append(newTagSection)
                } else {
                    tagItemView.section = tagSection.section
                    addRowItem(toSection: tagSection, tagItem: tagItemView)
                }
            }
        }
        
        drawTags()
    }
    
    func drawTags() {
        var tagSectionsTmp: [MyTagSectionProtocol] = []
        for (index, tagSection) in tagSections.enumerated() {
            let dimension = tagSection.dimension
            var rowsTmp: [UIView] = []
            for (index, tagItem) in tagSection.rows.enumerated() {
                guard let tagItemView = tagItem as? MyTagBaseItemView else { continue }
                addSubview(tagItemView)
                
                NSLayoutConstraint.activate([
                    tagItemView.widthAnchor.constraint(equalToConstant: tagItem.itemCanvas.width),
                    tagItemView.heightAnchor.constraint(equalToConstant: tagItem.itemCanvas.height)
                ])
                
                if let previousItemView = rowsTmp.last {
                    NSLayoutConstraint.activate([
                        tagItemView.topAnchor.constraint(equalTo: previousItemView.topAnchor),
                        tagItemView.leadingAnchor.constraint(equalTo: previousItemView.trailingAnchor,
                                                             constant: dimension.columnSpacing)
                    ])
                } else {
                    if let tagSectionTmp = tagSectionsTmp.last,
                       let tallestTagItemView = tagSectionTmp.tallestItemInRow as? MyTagBaseItemView {
                        tagItemView.topAnchor.constraint(greaterThanOrEqualTo: tallestTagItemView.bottomAnchor,
                                                         constant: dimension.rowSpacing)
                        .isActive = true
                    } else {
                        tagItemView.topAnchor.constraint(equalTo: topAnchor,
                                                         constant: dimension.inset.top)
                        .isActive = true
                    }
                    
                    switch tagSection.alignment {
                    case .left:
                        tagItemView.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                             constant: dimension.inset.left)
                        .isActive = true
                        
                    case .center:
                        tagItemView.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                             constant: tagSection.centerItemPadding)
                        .isActive = true
                        
                    case .right:
                        tagItemView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor,
                                                             constant: dimension.inset.left)
                        .isActive = true
                    }
                }
                
                if tagSection.rows.isLastItem(with: index) {
                    switch tagSection.alignment {
                    case .left:
                        tagItemView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor,
                                                              constant: -dimension.inset.right)
                        .isActive = true
                        
                    case .center:
                        tagItemView.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                              constant: -tagSection.centerItemPadding)
                        .isActive = true
                        
                    case .right:
                        tagItemView.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                              constant: -dimension.inset.right)
                        .isActive = true
                    }
                }
                rowsTmp.append(tagItemView)
            }
            tagSectionsTmp.append(tagSection)
            
            if tagSections.isLastItem(with: index),
               let tallestTagItemView = tagSection.tallestItemInRow as? MyTagBaseItemView {
                tallestTagItemView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor,
                                                           constant: -dimension.inset.bottom)
                .isActive = true
            }
        }
    }
    
    func drawExpandedTag(tagSection: MyTagSectionProtocol,
                         referenceSection section: Int) {
        guard let tagItemView = tagSection.rows.first as? MyTagBaseItemView else { return }
        addSubview(tagItemView)
        
        NSLayoutConstraint.activate([
            tagItemView.widthAnchor.constraint(equalToConstant: tagItemView.itemCanvas.width),
            tagItemView.heightAnchor.constraint(equalToConstant: tagItemView.itemCanvas.height)
        ])
        
        let dimension = tagSection.dimension
        if tagSections.count == 0 {
            tagItemView.topAnchor.constraint(equalTo: topAnchor,
                                             constant: dimension.inset.top)
            .isActive = true
        } else {
            let referenceTagSection = tagSections[section]
            if let tallestTagItemView = referenceTagSection.tallestItemInRow as? MyTagBaseItemView {
                tagItemView.topAnchor.constraint(equalTo: tallestTagItemView.bottomAnchor,
                                                 constant: dimension.rowSpacing)
                .isActive = true
            }
        }
        
        if tagSections.isLastItem(with: section) {
            tagItemView.bottomAnchor.constraint(equalTo: bottomAnchor,
                                                constant: -dimension.inset.bottom)
            .isActive = true
        } else {
            let nextTagSectionIndex = section + 1
            let nextTagSection = tagSections[nextTagSectionIndex]
            if let nextTagItemView = nextTagSection.rows.first as? MyTagBaseItemView {
                tagItemView.bottomAnchor.constraint(equalTo: nextTagItemView.topAnchor,
                                                    constant: -dimension.rowSpacing)
                .isActive = true
            }
        }
        
        switch tagSection.alignment {
        case .left:
            NSLayoutConstraint.activate([
                tagItemView.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                     constant: dimension.inset.left),
                tagItemView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor,
                                                      constant: -dimension.inset.right)
            ])
            
        case .center:
            NSLayoutConstraint.activate([
                tagItemView.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                     constant: tagSection.centerItemPadding),
                tagItemView.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                      constant: -tagSection.centerItemPadding)
            ])
            
        case .right:
            NSLayoutConstraint.activate([
                tagItemView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor,
                                                     constant: dimension.inset.left),
                tagItemView.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                      constant: -dimension.inset.right)
            ])
        }
    }
    
    func updateTagItemViews(for items: [MyTagItemProtocol]) {
        let rows = tagSections.flatMap { $0.rows }
        guard rows.count == items.count else { return }
        for (idx, item) in items.enumerated() {
            rows[idx].configure(item: item)
        }
    }
    
    // force reload tags
    func reloadTags() {
        guard let viewModel else { return }
        prepareTags(items: viewModel.items)
    }
    
    func updateTagItem(tagItem: MyTagItemProtocol,
                       tagView: MyTagItemViewProtocol,
                       state isSelected: Bool) {
        guard let viewModel else { return }
        var mutatedItem = tagItem
        mutatedItem.isSelected = isSelected
        viewModel.updateItem(with: mutatedItem)
        
        if viewModel.isMultiSelection {
            tagView.configure(item: mutatedItem)
        } else {
            updateTagItemViews(for: viewModel.items)
        }
    }
}

// MARK: - MyTagItemUpdateProtocol

extension MyTagCollectionView: MyTagItemUpdateProtocol {
    public func childItem(tagItem: MyTagItemProtocol,
                          tagView: MyTagItemViewProtocol,
                          requestAction action: MyTagItemUpdateAction) {
        switch action {
        case .isSelected(let state):
            updateTagItem(tagItem: tagItem,
                          tagView: tagView,
                          state: state)
        case .remove:
            guard let viewModel else { return }
            viewModel.removeItem(tagItem: tagItem)
            
        case .expandWith(let expandedItem):
            guard !tagItem.isSelected else { return }
            removeExpandedItem()
            updateTagItem(tagItem: tagItem,
                          tagView: tagView,
                          state: true)
            addExpandedItem(item: expandedItem,
                            referenceSection: tagView.section)
            
        case .collapse:
            removeExpandedItem()
            updateTagItem(tagItem: tagItem,
                          tagView: tagView,
                          state: false)
        }
    }
}

// MARK: - MyTagCollectionUpdateProtocol

extension MyTagCollectionView: MyTagCollectionUpdateProtocol {
    public func viewModel(viewModel: MyTagCollectionViewModelProtocol,
                          requestAction action: MyTagCollectionUpdateAction) {
        switch action {
        case .reload:
            prepareTags(items: viewModel.items)
        }
    }
}

public
extension MyTagCollectionView {
    func configure(viewModel: MyTagCollectionViewModelProtocol) {
        guard let vm = viewModel as? MyTagCollectionViewModel else { return }
        vm.viewDelegate = self
        self.viewModel = vm
        
        prepareTags(items: viewModel.items)
    }
}
