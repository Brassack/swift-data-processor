//
//  SDPSDPHashesSDPSDPHashesInteractorInput.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 31/07/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import Foundation

protocol SDPHashesInteractorInput {
    
    var stores:SDPReduxStores {get set}
    
    func unsubscribeFromSaltClipboard()
    func subscribeForSaltClipboard()
    func requestData(_:(iterations: Int, salt: String?))
    func copyHash(data: [SDPTableViewDataSourceSection], atIndexPath indexPath: IndexPath)
}
