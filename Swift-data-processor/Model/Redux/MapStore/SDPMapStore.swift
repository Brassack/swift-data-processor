//
//  SDPMapStore.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 8/23/18.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit
import ReSwift

class SDPMapStore: Store<SDPMapState> {

    static func mapReducer(action: Action, state: SDPMapState?) -> SDPMapState {
        // if no state has been provided, create the default state
        var state = state ?? SDPMapState()
        
        switch action {
        case let action as SDPMapStateWriteAction:
            
            state.map[action.key] = action.value
        case _ as SDPMapStateRemoveAllAction:
            
            state.map.removeAll()
        default:
            break
        }
        
        return state
    }
}
