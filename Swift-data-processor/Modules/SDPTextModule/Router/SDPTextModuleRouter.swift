//
// SDPTextRouter.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 15/07/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit

class SDPTextModuleRouter: SDPTextModuleRouterInput {
    
    weak var navigationController : UINavigationController?
    var mainStoryboard: UIStoryboard!
    var qrStoryboard: UIStoryboard!
    var actionsStoryboard: UIStoryboard!
    
    // MARK: DPTextRouterInput
    func registerNavigationController(forView view: Any?) {
        if let vc = view as? UIViewController {
            let action = SDPNavigationStateWriteAction(navigationController: vc.navigationController)
            SDPReduxStores.shared.navigationStore.dispatch(action)
        }
    }
    
    func show(errorMessage: String){
        
        let alert = UIAlertController(title: "Ooops", message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        navigationController?.present(alert, animated: true, completion: nil)
    }
    
    func qr() {
        let vc = qrStoryboard.instantiateViewController(withIdentifier: String(describing: SDPQRScannerModuleViewController.self))
        
        if let vc = vc as? SDPViewExternalConfiguratorProtocol{
            vc.externalConfigurator = SDPQRScannerModuleViewBackButtonExternalConfigurator()
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func showScreen(forAction action:String){
        
        if action == "SDPQRGenerator" {
            
            let vc = actionsStoryboard.instantiateViewController(withIdentifier: String(describing: SDPQRGeneratorViewController.self))
            navigationController?.pushViewController(vc, animated: true)
        }else if action == "SDPHashes" {
            
            let vc = actionsStoryboard.instantiateViewController(withIdentifier: String(describing: SDPHashesViewController.self))
            navigationController?.pushViewController(vc, animated: true)
        }else if action == "SDPEncryption" {
            //
            let vc = actionsStoryboard.instantiateViewController(withIdentifier: String(describing: SDPEncryptionViewController.self))
            navigationController?.pushViewController(vc, animated: true)
        }else if action == "SDPEscaping" {
            
            let vc = actionsStoryboard.instantiateViewController(withIdentifier: String(describing: SDPEscapingModuleViewController.self))
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func returnToRootController() {
        navigationController?.popToRootViewController(animated: true)
    }
}
