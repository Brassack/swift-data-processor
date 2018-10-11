//
//  SDPMapState.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 8/23/18.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import ReSwift
import Foundation

let defaultMinRandomNumber: UInt32 = 0
let defaultMaxRandomNumber: UInt32 = 100
let defaultRandomTextCount: Int = 1000
let defaultRandomLoremIpsumCount: Int = 100
let defaultRandomBinaryCount: Int = 1024

let maxRandomTextCount: Int = 10000
let maxRandomLoremIpsumCount: Int = 1000
let maxRandomBinaryCount: Int = 1024*1024

struct SDPRandomParametersState:StateType {

    var map: [AnyHashable:Any] = [AnyHashable:Any]()
    
    var selectedType = RandomType.text
    var selectedTextSubtype = RandomTextSubtype.uuid
    
    var uuid: String = UUID().uuidString
    var textCount: Int = defaultRandomTextCount
    var text: String = SDPRandom.randomString(count: defaultRandomTextCount)
    var loremIpsumCount: Int = defaultRandomLoremIpsumCount
    var loremIpsum: String = SDPRandom.randomLoremIpsum(wordsCount: defaultRandomLoremIpsumCount)
    
    var binaryCount: Int = defaultRandomBinaryCount
    var binary: Data = SDPRandom.randomBinary(count: defaultRandomBinaryCount)
    
    var minNumber = defaultMinRandomNumber
    var maxNumber = defaultMaxRandomNumber
    var number: UInt32 = SDPRandom.randomNumber(min: defaultMinRandomNumber, max: defaultMaxRandomNumber)
}

extension SDPRandomParametersState {
    
    enum RandomTextSubtype: Int, CaseIterable {
        case uuid = 0
        case text
        case loremIpsum
        
        func title() -> String {
            
            switch self {
            case .uuid:
                return "UUID"
            case .text:
                return "Text"
            case .loremIpsum:
                return "Lorem ipsum"
            }
        }
    }
    
    enum RandomType:Int, CaseIterable {
        case number = 0
        case text
        case binary
        
        func title() -> String {
            
            switch self {
            case .number:
                return "Number"
            case .text:
                return "Text"
            case .binary:
                return "Binary"
            }
        }
    }
}
