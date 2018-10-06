//
// SDPHashesInteractorInput.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 31/07/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import Foundation

protocol SDPHashesInteractorInput {
    
    func setupAndSubscripeToArgon2Parameters()
    func unsubscribeFromArgon2Clipboard()
    func unsubscribeFromSaltClipboard()
    func subscribeForSaltClipboard()
    func requestData(_:(iterations: Int, salt: String?))
}
