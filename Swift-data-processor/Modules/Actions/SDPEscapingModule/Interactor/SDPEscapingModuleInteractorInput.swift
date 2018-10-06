//
// SDPEscapingModuleInteractorInput.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 03/10/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import Foundation

protocol SDPEscapingModuleInteractorInput {

    func set(parameters: SDPEscapingModuleInteractor.EscapingParameters)
    func requestData()
}
