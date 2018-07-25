//
//  TexSDPTextRouter.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 15/07/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit

class SDPTextRouter: SDPTextRouterInput {
    
    var navigationController : UINavigationController? = nil
    var mainStoryboard: UIStoryboard!
    var accesoryStoryboard: UIStoryboard!
    
    // MARK: DPTextRouterInput
    func qr() {
        let vc = accesoryStoryboard.instantiateViewController(withIdentifier: "SDPQRScannerViewController")
        
        if let vc = vc as? SDPViewExternalConfiguratorProtocol{
            vc.externalConfigurator = SDPQRScannerViewBackButtonExternalConfigurator()
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func perform(action:String, forText text:String){
        print("\(action) for text \(text)")
    }
    
    func returnToRootController() {
        navigationController?.popToRootViewController(animated: true)
    }
}
