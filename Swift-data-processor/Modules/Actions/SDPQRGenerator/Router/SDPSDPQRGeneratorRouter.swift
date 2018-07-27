//
//  SDPQRGeneratorSDPSDPQRGeneratorRouter.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 25/07/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//
import UIKit

class SDPQRGeneratorRouter: SDPQRGeneratorRouterInput {
    var controllerToPresenting: UIViewController!

    func share(image: UIImage) {
         
         let imageToShare = [image]
         let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
         activityViewController.popoverPresentationController?.sourceView = controllerToPresenting.view
        
        controllerToPresenting.present(activityViewController, animated: true, completion: nil)
    }
}
