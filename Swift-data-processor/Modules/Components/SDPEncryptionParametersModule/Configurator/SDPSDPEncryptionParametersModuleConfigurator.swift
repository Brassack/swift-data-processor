//
//  SDPPEncryptionParametersModuleSDPPEncryptionParametersModuleConfigurator.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 08/10/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit

class SDPEncryptionParametersModuleModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? SDPEncryptionParametersModuleViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: SDPEncryptionParametersModuleViewController) {

        let router = SDPEncryptionParametersModuleRouter()

        let presenter = SDPEncryptionParametersModulePresenter()
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

        let interactor = SDPEncryptionParametersModuleInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
    }
}
