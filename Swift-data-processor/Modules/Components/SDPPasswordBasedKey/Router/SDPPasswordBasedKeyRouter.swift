//
// SDPPasswordBasedKeyRouter.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 11/09/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit
import ReSwift

class SDPPasswordBasedKeyRouter: SDPPasswordBasedKeyRouterInput, StoreSubscriber {

    var componentStoryboard: UIStoryboard!
    var actionsStoryboard: UIStoryboard!
    
    var stores = SDPReduxStores.shared
    weak var navigationController : UINavigationController?

    init() {
        stores.navigationStore.subscribe(self)
    }
    
    func newState(state: SDPNavigationState) {
        navigationController = state.navigationController
    }
        
    func showSaltView(intoView: UIView, forParent parent: UIViewController) {
        
        let vc = componentStoryboard.instantiateViewController(withIdentifier: String(describing: SDPSaltModuleViewController.self))
        parent.configureChildViewController(childController: vc, onView: intoView)
    }
    
    func pop() {
        navigationController?.popViewController(animated: true)
    }
    
    func scanQR() {
        let vc = componentStoryboard.instantiateViewController(withIdentifier: String(describing: SDPQRScannerModuleViewController.self))
        
        if let vc = vc as? SDPViewExternalConfiguratorProtocol{
            vc.externalConfigurator = SDPQRScannerModuleViewBackButtonExternalConfigurator()
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func share(data: Data){
        
        SDPSharingPresenter().share(data: data)
    }
}
