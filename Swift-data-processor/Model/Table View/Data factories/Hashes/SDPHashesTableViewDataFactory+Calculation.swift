//
//  SDPHashesTableViewDataFactory+Calculation.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 8/23/18.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import CatCrypto

extension SDPHashesTableViewDataFactory {
    
    class func calculateSectionData(from data: SDPHashesSectionInfo, withWeakFactoryContainer weakFactorycontainer: Weak<SDPHashesTableViewDataFactory>) -> SDPTableViewDataSourceSection? {
        
        var rows = [SDPTableViewDataSourceRow]()
        
        for row in data.rows {
            
            guard weakFactorycontainer.object != nil else{
                return nil
            }
            
            let calculator = SDPHashCalculatorFactory.calculator(forSection: data.identifier, info: row, withWeakOwnerContainer: weakFactorycontainer)
            
            guard let resultRow = calculator.calculate() else {
                continue
            }
            
            rows.append(resultRow)
        }
        
        return (identifier: data.identifier, title: data.title, rows: rows)
    }
}
