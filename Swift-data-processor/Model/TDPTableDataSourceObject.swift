//
//  SDPTableDataSourceObject.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 7/25/18.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit

class SDPSingleSectionTableDataSourceObject<Element:Hashable, Value>: NSObject {
    
    private let elements: [Element]
    private let values: [Element:Value]?
    
    init(elements e:[Element], values v:[Element:Value]?) {
        elements = e
        values = v
    }
    
    func numberOfRows() -> Int {
        return elements.count
    }

    func element(forRow: Int) -> (element:Element, value:Value?) {
        let element = elements[forRow]
        return (element, values?[element])
    }
}
