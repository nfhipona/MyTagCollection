//
//  MyTagCollectionView.swift
//  MyTagCollection
//
//  Created by Neil Francis Hipona on 8/6/23.
//

import Foundation

public
class MyTagCollectionView: UIView, MyTagCollectionViewProtocol {
    public var viewModel: MyTagCollectionViewModelProtocol?
    public var tagSections: [MyTagSection] = []
    
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
    
    func addRowItem(toSection: MyTagSection, tagItem: MyTagItemViewProtocol) {
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
    
    func prepareTags(items: [MyTagItemProtocol]) {
        prepareContentView()
        guard let viewModel else { return }
        let dimension = viewModel.dimension
        
        for item in items {
            let tagItemView = item.modelView.init(item: item,
                                                  dimension: dimension)
                .usingAutolayout()
            
            if tagSections.isEmpty {
                let tagSection = MyTagSection(section: 0,
                                              rows: [tagItemView],
                                              dimension: dimension,
                                              alignment: viewModel.alignment)
                tagSections.append(tagSection)
                
            } else if let tagSection = tagSections.last {
                if tagItemView.shouldDrawInNewRow(itemsInRow: tagSection.rows, dimension: tagSection.dimension) {
                    let newTagSection = MyTagSection(section: tagSection.section + 1,
                                                     rows: [tagItemView],
                                                     dimension: dimension,
                                                     alignment: viewModel.alignment)
                    tagSections.append(newTagSection)
                } else {
                    addRowItem(toSection: tagSection, tagItem: tagItemView)
                }
            }
        }
        
        drawTags()
    }
    
    func drawTags() {
        var tagSectionsTmp: [MyTagSection] = []
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
                        tagItemView.topAnchor.constraint(equalTo: tallestTagItemView.bottomAnchor,
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
                tallestTagItemView.bottomAnchor.constraint(equalTo: bottomAnchor,
                                                           constant: -dimension.inset.bottom)
                .isActive = true
            }
        }
    }
}

public
extension MyTagCollectionView {
    func configure(viewModel: MyTagCollectionViewModelProtocol) {
        self.viewModel = viewModel
        
        prepareTags(items: viewModel.items)
    }
}
