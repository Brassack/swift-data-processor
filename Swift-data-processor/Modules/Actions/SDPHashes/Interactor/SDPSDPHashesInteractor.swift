//
//  SDPSDPHashesSDPSDPHashesInteractor.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 31/07/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//
import ReSwift


class SDPHashesInteractor: SDPHashesInteractorInput, StoreSubscriber {

    static let saltKey: String = "SDPHashesSalt"

    weak var output: SDPHashesInteractorOutput!
    var hashesDataFactory: SDPHashesTableViewDataFactory?
    var text: String?
    private var hashParameters: (iterations: Int, salt: String?) = (iterations: 1, salt: nil)
    var stores = SDPReduxStores.shared
    private var saltSubscriber: SDPMapStoreSubscriberObject?
    
    // MARK: StoreSubscriber
    func newState(state: SDPMapState) {
        
        guard let text = state.map["SDPHashes"] as? String else {
            return
        }
        
        self.text = text
        stores.mapStore.unsubscribe(self)
        updateData()
        let action = SDPMapStateWriteAction(key: "SDPHashes", value: nil)
        stores.mapStore.dispatch(action)
    }
    
    // MARK: SDPHashesInteractorInput
    func unsubscribeFromSaltClipboard() {
        saltSubscriber = nil
    }
    
    func subscribeForSaltClipboard() {
        
        let action = SDPMapStateWriteAction(key: SDPQRScannerVariables.qrScannerWriteKey, value: SDPHashesInteractor.saltKey)
        stores.mapStore.dispatch(action)
        
        saltSubscriber = SDPMapStoreSubscriberObject(mapStore: stores.mapStore, key: SDPHashesInteractor.saltKey, newStateBlock: { [weak self](maybeText) in
            
            guard let text = maybeText as? String else {
                return
            }
            
            self?.output.setScanned(salt: text)
            self?.saltSubscriber = nil
            
            DispatchQueue.main.async {
                let action = SDPMapStateWriteAction(key: SDPHashesInteractor.saltKey, value: nil)
                self?.stores.mapStore.dispatch(action)
            }
        })
    }
    
    func copyHash(data: [SDPTableViewDataSourceSection], atIndexPath indexPath: IndexPath) {
        
        guard data.count > indexPath.section else {
            return
        }
        
        let section = data[indexPath.section]
        
        guard section.rows.count > indexPath.row else {
            return
        }
        
        guard !section.rows[indexPath.row].isFailed else {
            return
        }
        
        guard let hash = section.rows[indexPath.row].subtitle else{
            return
        }
        
        UIPasteboard.general.string = hash
        
        output.hashCopied(at: indexPath)
    }
    
    func requestData(_ parameters:(iterations: Int, salt: String?)) {
        
        hashParameters = parameters
        if self.text == nil {
            stores.mapStore.subscribe(self)
        }else{
            updateData()
        }
    }
    
    // MARK: Private
    private func updateData(){
        
        guard let text = text else {
            return
        }
        
        guard hashesDataFactory == nil || hashesDataFactory?.iterations != hashParameters.iterations || hashesDataFactory?.salt != hashParameters.salt else{
            return
        }
        
        hashesDataFactory = SDPHashesTableViewDataFactory(text: text, delegate: output)
        hashesDataFactory?.iterations = hashParameters.iterations
        hashesDataFactory?.salt = hashParameters.salt
        hashesDataFactory?.createData()
    }
}
