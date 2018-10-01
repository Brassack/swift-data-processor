//
//  SDPSDPEncryptionSDPSDPEncryptionConfigurator.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 10/09/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit

class SDPEncryptionModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? SDPEncryptionViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: SDPEncryptionViewController) {

        let router = SDPEncryptionRouter()

        let presenter = SDPEncryptionPresenter()
        let sb = UIStoryboard.components
        presenter.passwordBasedKeyViewFactory = {
            let vc = sb.instantiateViewController(withIdentifier: String(describing: SDPPasswordBasedKeyViewController.self))
            return vc
        }
        
        presenter.rawKeyViewFactory = {
            let vc = sb.instantiateViewController(withIdentifier: String(describing: SDPRawKeyModuleViewController.self))
            return vc
        }
        
        presenter.view = viewController
        presenter.router = router

        let interactor = SDPEncryptionInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
        
 
    }

}
