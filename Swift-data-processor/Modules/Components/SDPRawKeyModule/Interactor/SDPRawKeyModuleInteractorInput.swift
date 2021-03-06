//
// SDPRawKeyModuleInteractorInput.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 25/09/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import Foundation

protocol SDPRawKeyModuleInteractorInput {

    func requestData()
    func set(key: Data?)
}
