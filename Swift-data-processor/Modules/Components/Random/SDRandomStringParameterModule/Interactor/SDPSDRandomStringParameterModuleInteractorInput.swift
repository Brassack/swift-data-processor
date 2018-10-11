//
//  SDPRandomStringParameterModuleInteractorInput.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 10/10/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import Foundation

protocol SDPRandomTextParameterModuleInteractorInput {

    func requestData()
    func set(subtype: SDPRandomParametersState.RandomTextSubtype)
    func set(count: Int)
}
