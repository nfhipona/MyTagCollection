//
//  MyTagCollectionUpdateProtocol.swift
//  MyTagCollection
//
//  Created by Neil Francis Hipona on 8/10/23.
//

import Foundation

public
protocol MyTagCollectionUpdateProtocol: NSObjectProtocol {
    func viewModel(viewModel: MyTagCollectionViewModelProtocol,
                   requestAction action: MyTagCollectionUpdateAction)
}
