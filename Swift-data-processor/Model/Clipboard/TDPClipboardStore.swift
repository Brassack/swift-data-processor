//
//  Store.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 7/19/18.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//
//
import UIKit
import ReSwift

class SDPClipboardStore:Store<SDPTextClipboard> {

    static func clipboardReducer(action: Action, state: SDPTextClipboard?) -> SDPTextClipboard {
        // if no state has been provided, create the default state
        var state = state ?? SDPTextClipboard()

        switch action {
        case _ as SDPSetTextAction:
            state.text = (action as? SDPSetTextAction)?.text
        default:
            break
        }

        return state
    }
}
