//
//  SDPHashCalculator.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 8/28/18.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import CatCrypto

class SDPHashCalculator {
    
    let weakOwnerContainer: Weak<SDPHashesTableViewDataFactory>
    let info: SDPHashesRowInfo
    
    init(info:SDPHashesRowInfo, withWeakOwnerContainer weakOwnerContainer: Weak<SDPHashesTableViewDataFactory>) {
        
        self.info = info
        self.weakOwnerContainer = weakOwnerContainer
    }
    
    func calculate() -> SDPTableViewDataSourceRow? {
        
        var resultRow: SDPTableViewDataSourceRow = (identifier: info.identifier, isFailed: true, title: info.title, subtitle: "Something went wrong")
        
        guard let iterations = weakOwnerContainer.object?.iterations else {
            return nil
        }
        
        guard var text = weakOwnerContainer.object?.text else{
            return nil
        }
        
        for i in 0..<iterations {
            guard let factory = weakOwnerContainer.object else{
                return nil
            }
            
            text = (factory.salt == nil) ? text : text + factory.salt!
            
            let result = info.function.hash(password: text)
            if let hash = result.value {
                if i == (iterations - 1) {
                    resultRow.isFailed = false
                    resultRow.subtitle = hash
                }else{
                    text = hash
                }
                
            }else if let errorDescription = result.error?.errorDescription {
                resultRow.subtitle = errorDescription
                break
            }
        }
        
        return resultRow
    }
}
