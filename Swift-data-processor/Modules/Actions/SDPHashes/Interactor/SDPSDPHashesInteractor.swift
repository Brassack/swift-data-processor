//
//  SDPSDPHashesSDPSDPHashesInteractor.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 31/07/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//
import ReSwift


class SDPTextClipboardSubscriberObject: StoreSubscriber {
    
    let newStateBlock: (SDPTextClipboard) -> Void
    let clipboard: SDPClipboardStore
    
    init(clipboard: SDPClipboardStore, newStateBlock: @escaping (SDPTextClipboard) -> Void) {
        self.clipboard = clipboard
        self.newStateBlock = newStateBlock
        clipboard.subscribe(self)
    }
    
    deinit {
        clipboard.unsubscribe(self)
    }
    
    func newState(state: SDPTextClipboard) {
        newStateBlock(state)
    }
}

class SDPHashesInteractor: SDPHashesInteractorInput, StoreSubscriber {

    weak var output: SDPHashesInteractorOutput!
    var hashesDataFactory: SDPHashesTableViewDataFactory?
    var text: String?
    private var hashParameters: (iterations: Int, salt: String?) = (iterations: 1, salt: nil)
    var stores = SDPReduxStores.shared
    private var saltClipboardSubscriber:SDPTextClipboardSubscriberObject?
    private var storesForSaltClipboard:SDPReduxStores?
    
    // MARK: StoreSubscriber
    func newState(state: SDPTextClipboard) {
        
        guard let text = state.text else {
            return
        }
        
        self.text = text
        stores.clipboard.unsubscribe(self)
        updateData()
        let action = SDPSetTextAction(string:nil)
        stores.clipboard.dispatch(action)
    }
    
    // MARK: SDPHashesInteractorInput
    func unsubscribeFromSaltClipboard() {
        saltClipboardSubscriber = nil
        storesForSaltClipboard = nil
    }
    
    func requestStoresForSaltClipboard() {
        if let storesForSaltClipboard = storesForSaltClipboard {
            output.storesForSaltClipboardIsReady(stores: storesForSaltClipboard)
        }
        
        storesForSaltClipboard = SDPReduxStores()
        storesForSaltClipboard?.clipboard = SDPClipboardStore(
            reducer: SDPClipboardStore.clipboardReducer,
            state: nil
        )
        
        guard let storesForSaltClipboard = storesForSaltClipboard else {
            return
        }
        
        saltClipboardSubscriber = SDPTextClipboardSubscriberObject(clipboard: storesForSaltClipboard.clipboard, newStateBlock: { [weak self] (state)  in
            
            guard let text = state.text else {
                return
            }
            
            self?.output.setScanned(salt: text)
            
            self?.storesForSaltClipboard = nil
            self?.saltClipboardSubscriber = nil
        })
        
        output.storesForSaltClipboardIsReady(stores: storesForSaltClipboard)
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
            stores.clipboard.subscribe(self)
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
