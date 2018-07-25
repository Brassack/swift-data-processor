//
//  SDPReduxStores.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 7/25/18.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import Foundation
import ReSwift

class SDPReduxStores {
    static let shared = SDPReduxStores()
    
    let clipboard = SDPClipboardStore(
        reducer: SDPClipboardStore.clipboardReducer,
        state: nil
    )
}
