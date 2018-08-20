//
//  TexSDPTextRouter.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 15/07/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit

class SDPTextRouter: SDPTextRouterInput {
    
    weak var navigationController : UINavigationController?
    var mainStoryboard: UIStoryboard!
    var accesoryStoryboard: UIStoryboard!
    var actionsStoryboard: UIStoryboard!
    
    // MARK: DPTextRouterInput
    func qr() {
        let vc = accesoryStoryboard.instantiateViewController(withIdentifier: "SDPQRScannerViewController")
        
        if let vc = vc as? SDPViewExternalConfiguratorProtocol{
            vc.externalConfigurator = SDPQRScannerViewBackButtonExternalConfigurator()
        }
        
        ((vc as? SDPQRScannerViewInput)?.output
            as? SDPQRScannerModuleInput)?
            .interactor.stores = SDPReduxStores.shared
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func showScreen(forAction action:String){
        
        if action == "qr" {
            
            let vc = actionsStoryboard.instantiateViewController(withIdentifier: "SDPQRGeneratorViewController")
            
            ((vc as? SDPQRGeneratorViewInput)?.output
                as? SDPHashesModuleInput)?
                .interactor.stores = SDPReduxStores.shared
            
            navigationController?.pushViewController(vc, animated: true)
        }else if action == "hash" {
            
            let vc = actionsStoryboard.instantiateViewController(withIdentifier: "SDPHashesViewController")
            
            ((vc as? SDPHashesViewInput)?.output
                as? SDPHashesModuleInput)?
                .interactor.stores = SDPReduxStores.shared

            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func returnToRootController() {
        navigationController?.popToRootViewController(animated: true)
    }
}
