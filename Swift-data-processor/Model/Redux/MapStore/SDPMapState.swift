//
//  SDPMapState.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 8/23/18.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import ReSwift

struct SDPMapState:StateType {
    var map: [AnyHashable:Any] = [AnyHashable:Any]()
}
