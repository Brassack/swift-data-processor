//
// SDPRawKeyModuleRouter.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 25/09/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//
import ReSwift

class SDPRawKeyModuleRouter: SDPRawKeyModuleRouterInput, StoreSubscriber {

    var qrStoryboard: UIStoryboard!
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
        let vc = qrStoryboard.instantiateViewController(withIdentifier: String(describing: self))
        
        if let vc = vc as? SDPViewExternalConfiguratorProtocol{
            vc.externalConfigurator = SDPQRScannerModuleViewBackButtonExternalConfigurator()
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }
}
