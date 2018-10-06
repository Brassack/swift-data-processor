//
//  SDPArgon2ParametersPopupSDPArgon2ParametersPopupInteractorInput.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 27/08/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import Foundation

protocol SDPArgon2ParametersPopupInteractorInput {
    
    func setup()
    func parametersReady(_ parameters: SDPArgon2Parameters)
}
