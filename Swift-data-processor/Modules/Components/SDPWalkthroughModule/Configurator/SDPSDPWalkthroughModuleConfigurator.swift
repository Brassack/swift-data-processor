//
//  SDPSDPWalkthroughModuleSDPSDPWalkthroughModuleConfigurator.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 05/11/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit

class SDPWalkthroughModuleModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? SDPWalkthroughModuleViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: SDPWalkthroughModuleViewController) {

        let router = SDPWalkthroughModuleRouter()

        let presenter = SDPWalkthroughModulePresenter()
        presenter.slides = [(text: "Scan QR to text input", image: "scan-qr-walkthrough"),
                            (text: "Share text as QR code", image: "share-qr-walkthrough"),
                            (text: "Share binary data as base64 encoded data", image: "share-base64-walkthrough")]
        
        presenter.slideFactory = {(imageName, index) -> UIViewController? in
            
            guard let imageName = imageName as? String, let image = UIImage(named: imageName) else { return nil }
            let vc = SDPImageViewController()
            vc.view.tag = index
            vc.imageView.contentMode = .scaleAspectFit
            vc.imageView.image = image
            
            return vc
        }
        
        presenter.view = viewController
        presenter.router = router

        let interactor = SDPWalkthroughModuleInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
    }

}
