//
//  SDPPasswordBasedKeySDPSDPPasswordBasedKeyRouter.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 11/09/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit
import ReSwift

class SDPPasswordBasedKeyRouter: SDPPasswordBasedKeyRouterInput, StoreSubscriber {

    var componentStoryboard: UIStoryboard!
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
        
    func showSaltView(intoView: UIView, forParent parent: UIViewController) {
        
        let vc = componentStoryboard.instantiateViewController(withIdentifier: String(describing: SDPSaltModuleViewController.self))
        parent.configureChildViewController(childController: vc, onView: intoView)
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
    
    func share(text: String){
        
        guard let nc = navigationController else {
            return
        }
        
        let qrActivity = SDPQRGeneratingActivity(text: text, navigationController: nc, storyboard: actionsStoryboard)
        let activityViewController = UIActivityViewController(activityItems: [text], applicationActivities: [qrActivity])
        activityViewController.popoverPresentationController?.sourceView = nc.view // so that iPads won't crash
        
        nc.present(activityViewController, animated: true, completion: nil)
    }
}
