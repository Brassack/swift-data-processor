//
//  SDPEncryptionVariables.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 9/18/18.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import Foundation
typealias SDPEncryptionParameters = (password: String?, salt: String?, keySize:Int, computedRawKey: Data?, rawKey: Data?)

struct SDPEncryptionVariables {
    
    static let encryptionParametersKey = "SDPEncryptionParametersKey"
}
