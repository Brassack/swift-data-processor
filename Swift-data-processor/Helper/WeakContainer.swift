//
//  WeakContainer.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 8/3/18.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import Foundation

public struct Weak<T> where T: AnyObject {
    public weak var object: T?
    
    public init(_ object: T?) {
        self.object = object
    }
}
