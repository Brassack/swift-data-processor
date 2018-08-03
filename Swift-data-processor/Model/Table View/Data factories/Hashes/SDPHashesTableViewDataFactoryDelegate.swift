//
//  SDPHashesTableViewDataFactoryDelegate.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 8/3/18.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import Foundation

protocol SDPHashesTableViewDataFactoryDelegate: class {
    func set(stubData: [SDPTableViewDataSourceSection]?)
    func set(data: [SDPTableViewDataSourceSection]?)
}
