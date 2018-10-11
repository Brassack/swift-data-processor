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
    
    class func randomString(count: Int) -> String {
        
        let allowedChars = " abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let allowedCharsCount = UInt32(allowedChars.count)
        var randomString = ""
        
        for _ in 0..<count {
            let randomNum = Int(arc4random_uniform(allowedCharsCount))
            let randomIndex = allowedChars.index(allowedChars.startIndex, offsetBy: randomNum)
            let newCharacter = allowedChars[randomIndex]
            randomString += String(newCharacter)
        }
        
        return randomString
    }
    
    class func randomBinary(count: Int) -> Data {
        
        var keyData = Data(count: count)
        
        let _ = keyData.withUnsafeMutableBytes {
            SecRandomCopyBytes(kSecRandomDefault, count, $0)
        }
        
        return keyData
    }
    
    class func randomNumber(min: UInt32, max: UInt32) -> UInt32 {
        
        return arc4random_uniform(max - min + 1) + min
    }
    
    class func randomLoremIpsum(wordsCount: Int) -> String {
        
        var result = ""
        for counter in 0..<wordsCount {
  
            let index = Int(randomNumber(min: 0, max: UInt32(loremIpsumDictionaty.count) - 1))
            
            if counter == 0 {
                result.append(loremIpsumDictionaty[index].capitalized)
            }else{
                result.append(" ")
                result.append(loremIpsumDictionaty[index])
            }
        }

        result.append(".")
        
        return result
    }
}


extension SDPRandom {
    
    fileprivate static let loremIpsumDictionaty = "lorem ipsum dolor sit amet consectetur adipiscing elit sed do eiusmod tempor incididunt ut labore et dolore magna aliqua ut enim ad minim veniam quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur excepteur sint occaecat cupidatat non proident sunt in culpa qui officia deserunt mollit anim id est laborum".components(separatedBy: " ")
}
