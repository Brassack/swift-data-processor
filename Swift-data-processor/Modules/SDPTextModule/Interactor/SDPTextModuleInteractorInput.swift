
//
// SDPTextInteractorInput.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 15/07/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import Foundation

protocol SDPTextModuleInteractorInput {

    func requestActions()
    
    func set(text:String?)
    func set(range:NSRange?)
    
    func copy()
    func paste()
    
    func addTextToclipboard(action:String)
    func subscribeToClipboard()
    func unsubscribeFromClipboard()
}
