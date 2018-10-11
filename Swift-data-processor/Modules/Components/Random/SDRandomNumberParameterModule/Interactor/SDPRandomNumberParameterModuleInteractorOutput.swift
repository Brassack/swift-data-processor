//
//  SDPRandomNumberParameterModuleInteractorOutput.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 10/10/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import Foundation

protocol SDPRandomNumberParameterModuleInteractorOutput: class {

    func set(state: SDPRandomParametersState?)
    func invalidDataPassed()
}
