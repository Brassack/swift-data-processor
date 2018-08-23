//
//  SDPMapStateActions.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 8/23/18.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import ReSwift

struct SDPMapStateWriteAction:Action {
    let key: AnyHashable
    let value: Any?
    
    init(key: AnyHashable, value: Any?) {
        self.key = key
        self.value = value
    }
}

struct SDPMapStateRemoveAllAction:Action {
    
}
