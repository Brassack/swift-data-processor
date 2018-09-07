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
    case des3
    case rc2
    case rc4
    
    func algorithm() -> CCAlgorithm {
        
        switch self {
        case .aes:
            return CCAlgorithm(kCCAlgorithmAES)
        case .blowfish:
            return CCAlgorithm(kCCAlgorithmBlowfish)
        case .des3:
            return CCAlgorithm(kCCAlgorithm3DES)
        case .rc2:
            return CCAlgorithm(kCCAlgorithmRC2)
        case .rc4:
            return CCAlgorithm(kCCAlgorithmRC4)
            
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
        case .des3:
            return [kCCKeySize3DES]
        case .rc2:
            return enumerate(min: kCCKeySizeMinRC2, max: kCCKeySizeMinRC2)
        case .rc4:
            return enumerate(min: kCCKeySizeMinRC4, max: kCCKeySizeMinRC4)
        }
    }
}
