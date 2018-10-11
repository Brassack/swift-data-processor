//
//  SDPPEncryptionParametersModuleSDPPEncryptionParametersModuleInteractorInput.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 08/10/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import Foundation

protocol SDPEncryptionParametersModuleInteractorInput {

    func requestParameters()
    func update(parameters: SDPEncryptionParameters?)
}
