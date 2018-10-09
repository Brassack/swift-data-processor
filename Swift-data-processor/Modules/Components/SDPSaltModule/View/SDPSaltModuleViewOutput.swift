//
// SDPSaltModuleViewOutput.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 11/09/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit

protocol SDPSaltModuleViewOutput: UITextFieldDelegate {
    
    func viewIsReady()
    func generateRandomSalt()
}
