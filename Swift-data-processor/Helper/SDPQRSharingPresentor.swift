//
//  SDPQRSharingPresentor.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 10/2/18.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import ReSwift

class SDPQRSharingPresenter {
    
    var stroryboard: UIStoryboard = UIStoryboard.actions
    var stores = SDPReduxStores.shared
    
    func prepareDataAndPresentInRootController(text: String) {
        
        let action = SDPMapStateWriteAction(key: "SDPQRGenerator", value: text)
        stores.mapStore.dispatch(action)
        
        let vc = UIStoryboard.actions.instantiateViewController(withIdentifier: "SDPQRGeneratorViewController")
        let nc = UINavigationController.init(rootViewController: vc)
        vc.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: nc, action: #selector(UIViewController.dismissFromParentAnimated))
        
        UIApplication.shared.keyWindow?.rootViewController?.present(nc, animated: true, completion: nil)
    }
}
