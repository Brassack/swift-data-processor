//
//  SDPRandomNumberParameterModuleInteractorInput.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 10/10/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import Foundation

protocol SDPRandomNumberParameterModuleInteractorInput {

    func requestData()
    func update(min: UInt32, max: UInt32)
}
