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
    func registerNavigationController(forView view: Any?) {
        if let vc = view as? UIViewController {
            let action = SDPNavigationStateWriteAction(navigationController: vc.navigationController)
            SDPReduxStores.shared.navigationStore.dispatch(action)
        }
    }
    
    func showTooLongTextFoQRError(){
        
        let alert = UIAlertController(title: "Ooops", message: "Too long for QR (max 1024)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        navigationController?.present(alert, animated: true, completion: nil)
    }
    
    func qr() {
        let vc = accesoryStoryboard.instantiateViewController(withIdentifier: "SDPQRScannerViewController")
        
        if let vc = vc as? SDPViewExternalConfiguratorProtocol{
            vc.externalConfigurator = SDPQRScannerViewBackButtonExternalConfigurator()
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func showScreen(forAction action:String){
        
        if action == "SDPQRGenerator" {
            
            let vc = actionsStoryboard.instantiateViewController(withIdentifier: "SDPQRGeneratorViewController")
            
            navigationController?.pushViewController(vc, animated: true)
        }else if action == "SDPHashes" {
            //router
            let vc = actionsStoryboard.instantiateViewController(withIdentifier: "SDPHashesViewController")

            navigationController?.pushViewController(vc, animated: true)
        }else if action == "SDPEncryption" {
            //router
            let vc = actionsStoryboard.instantiateViewController(withIdentifier: "SDPEncryptionViewController")
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func returnToRootController() {
        navigationController?.popToRootViewController(animated: true)
    }
}
