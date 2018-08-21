//
//  SDPHashesSDPSDPHashesRouter.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 31/07/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//
import UIKit

class SDPHashesRouter: SDPHashesRouterInput {
    
    weak var navigationController : UINavigationController?
    var accesoryStoryboard: UIStoryboard!
    
    func returnTo(view: UIViewController) {
        navigationController?.popToViewController(view, animated: true)
    }
    
    func scanQR(stores: SDPReduxStores) {
        let vc = accesoryStoryboard.instantiateViewController(withIdentifier: "SDPQRScannerViewController")
        
        if let vc = vc as? SDPViewExternalConfiguratorProtocol{
            vc.externalConfigurator = SDPQRScannerViewBackButtonExternalConfigurator()
        }
        
        if let input = ((vc as? SDPQRScannerViewInput)?.output
            as? SDPQRScannerModuleInput) {
            
            input.interactor.stores = stores
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }
}
