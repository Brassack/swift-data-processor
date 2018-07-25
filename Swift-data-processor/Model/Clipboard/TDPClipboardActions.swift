//
//  SDPClipboardActions.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 7/25/18.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import Foundation
import ReSwift

struct SDPSetTextAction:Action {
    let text: String?
    
    init(string: String?) {
        text = string
    }
}
