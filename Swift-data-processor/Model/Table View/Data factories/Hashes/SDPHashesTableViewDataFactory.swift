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
    
    
    init(text: String, delegate: SDPHashesTableViewDataFactoryDelegate){
        self.text = text
        self.delegate = delegate
    }
    
    func createData(){
        weak var wself = self
        
        var result = [SDPTableViewDataSourceSection]()
        var infoArray = [SDPSectionInfo]()
        
        let shaSectionInfo = SDPHashesTableViewDataFactory.shaSectionInfo()
        infoArray.append(shaSectionInfo)
        
        let mdSectionInfo = SDPHashesTableViewDataFactory.mdSectionInfo()
        infoArray.append(mdSectionInfo)

        for info in infoArray {
            result.append(SDPHashesTableViewDataFactory.sectionDataToStubResultSectionData(data: info))
        }
        
        wself?.delegate?.set(stubData: result)
        
        DispatchQueue.global(qos: .background).async {
            
            let wselfContainer = Weak<SDPHashesTableViewDataFactory>(wself)
            
            for i in 0..<infoArray.count {
                guard wself != nil else{
                    return
                }
                
                let info = infoArray[i]
                
                if let data = SDPHashesTableViewDataFactory.calculateSectionData(from: info, withWeakFactoryContainer: wselfContainer){
                    result[i] = data
                }
                
                DispatchQueue.main.async {
                    wself?.delegate?.set(data: result)
                }
            }
            
        }
    }
    
    class func calculateSectionData(from data: SDPSectionInfo, withWeakFactoryContainer weakFactorycontainer: Weak<SDPHashesTableViewDataFactory>) -> SDPTableViewDataSourceSection? {
        
        var rows = [SDPTableViewDataSourceRow]()
        
        for row in data.rows {
            guard let iterations = weakFactorycontainer.object?.iterations else {
                return nil
            }
            
            var resultRow: SDPTableViewDataSourceRow = (identifier: row.identifier, isFailed: true, title: row.title, subtitle: "Something went wrong")
            
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
    
    class func sectionDataToStubResultSectionData(data: SDPSectionInfo) -> SDPTableViewDataSourceSection {
        
        var rows = [SDPTableViewDataSourceRow]()

        for row in data.rows {
            rows.append((identifier: row.identifier, isFailed: false, title: row.title, subtitle: nil))
        }
        
        return (identifier: data.identifier, title: data.title, rows: rows)
    }

}
