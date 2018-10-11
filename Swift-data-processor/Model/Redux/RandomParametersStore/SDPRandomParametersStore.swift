//
//  SDPMapStore.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 8/23/18.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit
import ReSwift

class SDPRandomParametersStore: Store<SDPRandomParametersState> {

    static func stateReducer(action: Action, state: SDPRandomParametersState?) -> SDPRandomParametersState {
        // if no state has been provided, create the default state
        var state = state ?? SDPRandomParametersState()
    
        switch action {
        case let action as SDPRandomParametersStateSetNumberBoundsAction:
            
            if state.minNumber != action.min || state.maxNumber != action.max {
                state.minNumber = action.min
                state.maxNumber = action.max
                state.number = SDPRandom.randomNumber(min: state.minNumber, max: state.maxNumber)
            }
        case let action as SDPRandomParametersStateSetTextLimitationAction:
            
            if state.textCount != action.count {
                state.textCount = action.count
                state.text = SDPRandom.randomString(count: state.textCount)
            }
        case let action as SDPRandomParametersStateSetLoremIpsumLimitationAction:

            if state.loremIpsumCount != action.wordsCount {
                state.loremIpsumCount = action.wordsCount
                state.loremIpsum = SDPRandom.randomLoremIpsum(wordsCount: state.loremIpsumCount)
            }
        case let action as SDPRandomParametersStateSetBinaryLimitationAction:

            if state.binaryCount != action.count {
                state.binaryCount = action.count
                state.binary = SDPRandom.randomBinary(count: state.binaryCount)
            }
        case let action as SDPRandomParametersStateSetTypeAction:
            
            state.selectedType = action.type
        case let action as SDPRandomParametersStateSetTextSubtypeAction:
            
            state.selectedTextSubtype = action.type
        case _ as SDPRandomParametersGenerateSelectedAction:
            
            switch state.selectedType {
            case .number:
                
                state.number = SDPRandom.randomNumber(min: state.minNumber, max: state.maxNumber)
            case .text:
                
                switch state.selectedTextSubtype{
                case .uuid:
                    state.uuid = UUID().uuidString
                case .text:
                    state.text = SDPRandom.randomString(count: state.textCount)
                case .loremIpsum:
                    state.loremIpsum = SDPRandom.randomLoremIpsum(wordsCount: state.loremIpsumCount)
                }
            case .binary:
                
                state.binary = SDPRandom.randomBinary(count: state.binaryCount)
            }
//        case _ as SDPRandomParametersGenerateNumberAction:
//            
//            state.number = SDPRandom.randomNumber(min: state.minNumber, max: state.maxNumber)
//        case _ as SDPRandomParametersGenerateTextAction:
//            
//            state.text = SDPRandom.randomString(count: state.textCount)
//        case _ as SDPRandomParametersGenerateLoremIpsumAction:
//        
//            state.loremIpsum = SDPRandom.randomLoremIpsum(wordsCount: state.loremIpsumCount)
//        case _ as SDPRandomParametersGenerateBinaryAction:
//            
//            state.binary = SDPRandom.randomBinary(count: state.binaryCount)
//        case _ as SDPRandomParametersGenerateUUIDAction:
//
//            state.uuid = UUID().uuidString
        default:
            break
        }
        
        return state
    }
}
