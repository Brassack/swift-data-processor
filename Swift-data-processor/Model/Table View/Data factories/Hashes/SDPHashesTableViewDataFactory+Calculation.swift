//
//  SDPHashesTableViewDataFactory+Calculation.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 8/23/18.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import CatCrypto

extension SDPHashesTableViewDataFactory {
    
    class func calculateArgon2SectionData(from data: SDPSectionInfo, withWeakFactoryContainer weakFactorycontainer: Weak<SDPHashesTableViewDataFactory>) -> SDPTableViewDataSourceSection? {
        
        var rows = [SDPTableViewDataSourceRow]()
        
        for row in data.rows {
            var resultRow: SDPTableViewDataSourceRow = (identifier: row.identifier, isFailed: true, title: row.title, subtitle: "Something went wrong")
            
            guard let text = weakFactorycontainer.object?.text else{
                return nil
            }
            
            guard let function = row.function as? CatArgon2Crypto else{
                return nil
            }
            
            var optionalResult:CatCryptoExternalResult? = nil
            
            if row.identifier.range(of: "_encoded") == nil {
                optionalResult = function.rawHash(password: text)
            }else{
                let r = function.hash(password: text)
                optionalResult = CatCryptoExternalResult(result: r)
            }
            
            guard let result = optionalResult else{
                return nil
            }
            
            if let hash = result.value {
                
                resultRow.isFailed = false
                resultRow.subtitle = hash
            }else if let errorDescription = result.error?.errorDescription {
                
                resultRow.subtitle = errorDescription
                break
            }
            
            rows.append(resultRow)
        }
        
        return (identifier: data.identifier, title: data.title, rows: rows)
    }
    
    class func calculateSectionData(from data: SDPSectionInfo, withWeakFactoryContainer weakFactorycontainer: Weak<SDPHashesTableViewDataFactory>) -> SDPTableViewDataSourceSection? {
        
        if data.identifier == "argon2" {
            
            return self.calculateArgon2SectionData(from: data, withWeakFactoryContainer: weakFactorycontainer)
        }
        
        var rows = [SDPTableViewDataSourceRow]()
        
        for row in data.rows {
            
            var resultRow: SDPTableViewDataSourceRow = (identifier: row.identifier, isFailed: true, title: row.title, subtitle: "Something went wrong")
            
            guard let iterations = weakFactorycontainer.object?.iterations else {
                return nil
            }
            
            guard var text = weakFactorycontainer.object?.text else{
                return nil
            }
            
            for i in 0..<iterations {
                guard let factory = weakFactorycontainer.object else{
                    return nil
                }
                
                text = (factory.salt == nil) ? text : text + factory.salt!
                
                let result = row.function.hash(password: text)
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
            
            rows.append(resultRow)
        }
        
        return (identifier: data.identifier, title: data.title, rows: rows)
    }
}
