//
//  QRScannerDPQRScannerRouter.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 19/07/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit

class SDPQRScannerRouter: SDPQRScannerRouterInput {
    var navigationController: UINavigationController?
    
    func show(alert:(title:String?, message:String?)){
        
        let alert = UIAlertController(title: alert.title, message: alert.message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        navigationController?.present(alert, animated: true, completion:nil)
    }

}
