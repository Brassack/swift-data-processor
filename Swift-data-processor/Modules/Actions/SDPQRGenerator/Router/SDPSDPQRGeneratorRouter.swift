//
//  SDPQRGeneratorSDPSDPQRGeneratorRouter.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 25/07/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//
import UIKit

class SDPQRGeneratorRouter: SDPQRGeneratorRouterInput {
    weak var controllerToPresenting: UIViewController?

    func share(image: UIImage) {
        
        var base64Activity:SDPBase64GeneratingActivity? = nil
        if let data = UIImagePNGRepresentation(image) {
            base64Activity = SDPBase64GeneratingActivity(data: data)
        }
        let activities = base64Activity == nil ? [] : [base64Activity!]
        
         let imageToShare = [image]
         let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities:activities)
        activityViewController.popoverPresentationController?.sourceView = controllerToPresenting?.view
        
        controllerToPresenting?.present(activityViewController, animated: true, completion: nil)
    }
}
