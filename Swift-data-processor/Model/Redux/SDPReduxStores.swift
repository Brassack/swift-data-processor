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
    
    var navigationStore = SDPNavigationStore(
        reducer: SDPNavigationStore.navigationReducer,
        state: nil
    )
    
    var mapStore = SDPMapStore(
        reducer: SDPMapStore.mapReducer,
        state: nil
    )
}
