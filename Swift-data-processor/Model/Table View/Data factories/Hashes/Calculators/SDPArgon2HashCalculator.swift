//
//  SDPArgon2HashCalculator.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 8/28/18.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import CatCrypto

class SDPArgon2HashCalculator: SDPHashCalculator {
    
    override func calculate() -> SDPTableViewDataSourceRow? {
        
        var resultRow: SDPTableViewDataSourceRow = (identifier: info.identifier, isFailed: true, title: info.title, subtitle: "Something went wrong")
        
        guard let text = weakOwnerContainer.object?.text else{
            return nil
        }
        
        guard let function = info.function as? CatArgon2Crypto else{
            return nil
        }
        guard let salt = weakOwnerContainer.object?.salt else{
            return nil
        }
        
        function.context.salt = salt
        
        var optionalResult:CatCryptoExternalResult? = nil
        
        if info.identifier.range(of: "_encoded") == nil {
            
            optionalResult = function.rawHash(password: text)
        }else{
            
            let r = function.hash(password: text)
            optionalResult = CatCryptoExternalResult()
            optionalResult?.value = r.stringValue()
        }
        
        guard let result = optionalResult else{
            return nil
        }
        
        if let hash = result.value {
            
            resultRow.isFailed = false
            resultRow.subtitle = hash
        }else if let errorDescription = result.error?.errorDescription {
            
            resultRow.subtitle = errorDescription
        }
        
        return resultRow
    }
}
