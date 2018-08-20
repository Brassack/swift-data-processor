//
//  DPQRScannerDPQRScannerInteractor.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 19/07/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

class SDPQRScannerInteractor: SDPQRScannerInteractorInput {

    weak var output: SDPQRScannerInteractorOutput!
    var stores = SDPReduxStores.shared

    func textReady(_ text: String) {
        let action = SDPSetTextAction(string:text)
        stores.clipboard.dispatch(action)
    }
}
