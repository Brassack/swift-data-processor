//
//  File.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 8/23/18.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import ReSwift

class SDPMapStoreSubscriberObject: StoreSubscriber {
    
    let newStateBlock: (Any) -> Void
    let mapStore: SDPMapStore
    let key: AnyHashable
    
    init(mapStore: SDPMapStore, key: AnyHashable, newStateBlock: @escaping (Any) -> Void) {
        self.mapStore = mapStore
        self.key = key
        self.newStateBlock = newStateBlock
        mapStore.subscribe(self)
    }
    
    deinit {
        mapStore.unsubscribe(self)
    }
    
    func newState(state: SDPMapState) {
        if let value = state.map[key] {
            newStateBlock(value)
        }
    }
}
