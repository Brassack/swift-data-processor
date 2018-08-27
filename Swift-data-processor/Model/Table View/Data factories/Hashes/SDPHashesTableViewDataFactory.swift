//
//  SDPHashesTableViewDataFactory.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 7/31/18.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit
import CatCrypto


typealias SDPSectionInfo = (identifier: String,
    title: String,
    rows: [(identifier: String, title: String, function: Hashing)])

class SDPHashesTableViewDataFactory {
    
    let text: String
    weak var delegate: SDPHashesTableViewDataFactoryDelegate?
    var iterations: Int = 1
    var salt: String?
    
    var argon2HashLength: Int = argon2DefaultHashLength
    var argon2Memory: Int = argon2DefaultMemory
    var argon2Parallelism: Int = argon2DefaultParallelism
    
    init(text: String, delegate: SDPHashesTableViewDataFactoryDelegate){
        self.text = text
        self.delegate = delegate
    }
    
    func createData(){
        
        var result = [SDPTableViewDataSourceSection]()
        var infoArray = [SDPSectionInfo]()
        
        let shaSectionInfo = SDPHashesTableViewDataFactory.shaSectionInfo()
        infoArray.append(shaSectionInfo)
        
        let mdSectionInfo = SDPHashesTableViewDataFactory.mdSectionInfo()
        infoArray.append(mdSectionInfo)
        
        if (salt?.count ?? 0) >= 8 {
            let argon2SectionInfo = SDPHashesTableViewDataFactory.argon2SectionInfo(iteractions: iterations, hashLength: argon2HashLength, parallelism: argon2Parallelism, memory: argon2Memory)
            infoArray.append(argon2SectionInfo)
        }

        for info in infoArray {
            result.append(SDPHashesTableViewDataFactory.sectionDataToStubResultSectionData(data: info))
        }
        
        delegate?.set(stubData: result)
            
        DispatchQueue.global(qos: .background).async { [weak self] in
            
            let wselfContainer = Weak<SDPHashesTableViewDataFactory>(self)
            
            for i in 0..<infoArray.count {
                guard self != nil else{
                    return
                }
                
                let info = infoArray[i]
                
                if let data = SDPHashesTableViewDataFactory.calculateSectionData(from: info, withWeakFactoryContainer: wselfContainer){
                    result[i] = data
                }
                
                DispatchQueue.main.async {
                    self?.delegate?.set(data: result)
                }
            }
            
        }
    }
    
   
    class func sectionDataToStubResultSectionData(data: SDPSectionInfo) -> SDPTableViewDataSourceSection {
        
        var rows = [SDPTableViewDataSourceRow]()

        for row in data.rows {
            rows.append((identifier: row.identifier, isFailed: false, title: row.title, subtitle: nil))
        }
        
        return (identifier: data.identifier, title: data.title, rows: rows)
    }

}
