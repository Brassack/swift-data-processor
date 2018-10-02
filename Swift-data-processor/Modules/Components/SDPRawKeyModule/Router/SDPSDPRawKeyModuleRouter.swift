//
//  SDPRawKeyModuleSDPSDPRawKeyModuleRouter.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 25/09/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//
import ReSwift

class SDPRawKeyModuleRouter: SDPRawKeyModuleRouterInput, StoreSubscriber {

    var accesoryStoryboard: UIStoryboard!
    var actionsStoryboard: UIStoryboard!

    var stores = SDPReduxStores.shared
    weak var navigationController : UINavigationController?
    
    init() {
        stores.navigationStore.subscribe(self)
    }
    
    func newState(state: SDPNavigationState) {
        navigationController = state.navigationController
    }
    
    func pop() {
        navigationController?.popViewController(animated: true)
    }
    
    func scanQR() {
        let vc = accesoryStoryboard.instantiateViewController(withIdentifier: "SDPQRScannerViewController")
        
        if let vc = vc as? SDPViewExternalConfiguratorProtocol{
            vc.externalConfigurator = SDPQRScannerViewBackButtonExternalConfigurator()
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }
}