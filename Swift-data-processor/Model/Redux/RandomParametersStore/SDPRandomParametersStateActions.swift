//
//  SDPMapStateActions.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 8/23/18.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import ReSwift

struct SDPRandomParametersStateSetNumberBoundsAction: Action {
    let min: UInt32
    let max: UInt32
    
    init?(min: UInt32, max: UInt32) {
        
        guard min < max else {
            return nil
        }
        
        self.min = min
        self.max = max
    }
}

struct SDPRandomParametersStateSetTextLimitationAction: Action {
    let count: Int
    
    init?(count: Int) {
        
        guard count < maxRandomTextCount else {
            return nil
        }
        
        self.count = count
    }
}

struct SDPRandomParametersStateSetLoremIpsumLimitationAction: Action {
    let wordsCount: Int
    
    init?(wordsCount: Int) {
        
        guard wordsCount < maxRandomLoremIpsumCount else {
            return nil
        }
        
        self.wordsCount = wordsCount
    }
}

struct SDPRandomParametersStateSetBinaryLimitationAction: Action {
    let count: Int
    
    init?(count: Int) {
        
        guard count < maxRandomBinaryCount, count > 0 else {
            return nil
        }
        
        self.count = count
    }
}

struct SDPRandomParametersStateSetTypeAction: Action {
    let type: SDPRandomParametersState.RandomType
    
    init(type: SDPRandomParametersState.RandomType) {
        self.type = type
    }
}

struct SDPRandomParametersStateSetTextSubtypeAction: Action {
    let type: SDPRandomParametersState.RandomTextSubtype
    
    init(type: SDPRandomParametersState.RandomTextSubtype) {
        self.type = type
    }
}

struct SDPRandomParametersGenerateSelectedAction: Action {}

//struct SDPRandomParametersGenerateNumberAction: Action {}
//struct SDPRandomParametersGenerateTextAction: Action {}
//struct SDPRandomParametersGenerateLoremIpsumAction: Action {}
//struct SDPRandomParametersGenerateBinaryAction: Action {}
//struct SDPRandomParametersGenerateUUIDAction: Action {}
