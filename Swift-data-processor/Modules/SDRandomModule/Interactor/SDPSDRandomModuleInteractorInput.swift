//
//  SDPRandomModuleInteractorInput.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 09/10/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import Foundation

protocol SDPRandomModuleInteractorInput {

    func random()
    func set(type: SDPRandomParametersState.RandomType)
    func requestData()
}
