//
//  SDPSaltModuleSDPSDPSaltModuleRouter.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 11/09/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//
import ReSwift
import UIKit

class SDPSaltModuleRouter: SDPSaltModuleRouterInput, StoreSubscriber {

    weak var navigationController : UINavigationController?
    var qrStoryboard: UIStoryboard!
    var actionsStoryboard: UIStoryboard!
    var popupReference: Any?
    var stores = SDPReduxStores.shared
    
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
        let vc = qrStoryboard.instantiateViewController(withIdentifier: String(describing: SDPQRScannerModuleViewController.self))
        
        if let vc = vc as? SDPViewExternalConfiguratorProtocol{
            vc.externalConfigurator = SDPQRScannerModuleViewBackButtonExternalConfigurator()
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }
}
