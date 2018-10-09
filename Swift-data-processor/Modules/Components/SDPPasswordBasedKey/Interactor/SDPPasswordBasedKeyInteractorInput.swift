//
// SDPPasswordBasedKeyInteractorInput.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 11/09/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import Foundation

protocol SDPPasswordBasedKeyInteractorInput {

    func requestData()
    func set(parameters: SDPEncryptionParameters?)
}
