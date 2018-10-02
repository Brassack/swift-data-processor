//
//  SDPQRSharingPresentor.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 10/2/18.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import ReSwift

class SDPSharingPresenter {
    
    var stroryboard: UIStoryboard = UIStoryboard.actions
    var stores = SDPReduxStores.shared
    
    func qrSharePrepareDataAndPresentInRootController(text: String) {
        
        let action = SDPMapStateWriteAction(key: "SDPQRGenerator", value: text)
        stores.mapStore.dispatch(action)
        
        let vc = UIStoryboard.actions.instantiateViewController(withIdentifier: "SDPQRGeneratorViewController")
        let nc = UINavigationController.init(rootViewController: vc)
        vc.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: nc, action: #selector(UIViewController.dismissFromParentAnimated))
        
        UIApplication.shared.keyWindow?.rootViewController?.present(nc, animated: true, completion: nil)
    }
    
    func share(string: String) {
        
        guard let rootVC = UIApplication.shared.keyWindow?.rootViewController else {
            return
        }
        
        let qrActivity = SDPQRGeneratingActivity(text: string, qrStoryboard: stroryboard)
        let activities = qrActivity == nil ? [] : [qrActivity!]
        let activityViewController = UIActivityViewController(activityItems: [string], applicationActivities: activities)
        activityViewController.popoverPresentationController?.sourceView = rootVC.view // so that iPads won't crash
        
        rootVC.present(activityViewController, animated: true, completion: nil)
    }
    
    func share(data: Data) {
        
        guard let rootVC = UIApplication.shared.keyWindow?.rootViewController else {
            return
        }
        
        let base64Activity = SDPBase64GeneratingActivity(data: data)
        let activities = base64Activity == nil ? [] : [base64Activity!]
        let activityViewController = UIActivityViewController(activityItems: [data], applicationActivities: activities)
        activityViewController.popoverPresentationController?.sourceView = rootVC.view // so that iPads won't crash
        
        rootVC.present(activityViewController, animated: true, completion: nil)
    }
}
