//
// SDPRawKeyModuleViewOutput.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 25/09/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit

protocol SDPRawKeyModuleViewOutput {

    func viewIsReady()
    
    func generateRandomKey()
    func set(key: String?)
    func setTextInProgress(_ text:String?)
}
