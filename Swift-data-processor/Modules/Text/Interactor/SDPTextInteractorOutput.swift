//
//  DPTexSDPTextInteractorOutput.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 15/07/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import Foundation

protocol SDPTextInteractorOutput: class {
    
    func set(text:String?)
    func textAddedToClipboard()
    func set(actions:[String], titles: [String: String]?)
}
