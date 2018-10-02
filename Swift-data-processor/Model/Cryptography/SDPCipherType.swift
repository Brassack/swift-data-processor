//
//  SDPCipherType.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 9/7/18.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import CommonCrypto


enum SDPCipherType {
    case aes
    case blowfish
    
    func description() -> String {
        
        switch self {
        case .aes:
            return "AES"
        case .blowfish:
            return "Blowfish"
        }
    }
    
    func algorithm() -> CCAlgorithm {
        
        switch self {
        case .aes:
            return CCAlgorithm(kCCAlgorithmAES)
        case .blowfish:
            return CCAlgorithm(kCCAlgorithmBlowfish)
        }
    }
    
    func defaultKeySize() -> Int {
        
        switch self {
        case .aes:
            return kCCKeySizeAES256
        case .blowfish:
            return kCCKeySizeMaxBlowfish
        }
    }
    func keySizeList() -> [Int] {
        
        func enumerate(min: Int, max: Int) -> [Int] {
            
            var result = [Int]()
            for i in min...max {
                result.append(i)
            }
            return result
        }
        
        switch self {
        case .aes:
            return [kCCKeySizeAES128, kCCKeySizeAES192, kCCKeySizeAES256]
        case .blowfish:
            return enumerate(min: kCCKeySizeMinBlowfish, max: kCCKeySizeMaxBlowfish)
        }
    }
}
