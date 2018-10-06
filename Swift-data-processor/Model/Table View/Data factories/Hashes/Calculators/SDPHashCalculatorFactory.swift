//
//  SDPHashCalculatorFactory.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 8/28/18.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import CatCrypto

class SDPHashCalculatorFactory {
    
    class func calculator(forSection sectionID: String, info: SDPHashesRowInfo, withWeakOwnerContainer weakOwnerContainer: Weak<SDPHashesTableViewDataFactory>) -> SDPHashCalculator {
        
        if sectionID == "argon2" {
            
            return SDPArgon2HashCalculator(info: info, withWeakOwnerContainer: weakOwnerContainer)
        }else{
            
            return SDPHashCalculator(info: info, withWeakOwnerContainer: weakOwnerContainer)
        }
    }
}
