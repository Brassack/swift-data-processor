//
//  SDPNavigationStore.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 8/23/18.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit
import ReSwift

class SDPNavigationStore: Store<SDPNavigationState> {
    
    static func navigationReducer(action: Action, state: SDPNavigationState?) -> SDPNavigationState {
        // if no state has been provided, create the default state
        var state = state ?? SDPNavigationState()
        
        switch action {
        case let action as SDPNavigationStateWriteAction:
            
            state.navigationController = action.nc
        default:
            break
        }
        
        return state
    }
}
