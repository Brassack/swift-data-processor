//
//  SDPRandom.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 8/3/18.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit

class SDPRandom {
    
    class func randomSalt() -> String {
        let length = 16
        let allowedChars = "abcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*()_+-=[]{}|<>?"
        let allowedCharsCount = UInt32(allowedChars.count)
        var randomString = ""
        
        for _ in 0..<length {
            let randomNum = Int(arc4random_uniform(allowedCharsCount))
            let randomIndex = allowedChars.index(allowedChars.startIndex, offsetBy: randomNum)
            let newCharacter = allowedChars[randomIndex]
            randomString += String(newCharacter)
        }
        
        return randomString
    }
}
