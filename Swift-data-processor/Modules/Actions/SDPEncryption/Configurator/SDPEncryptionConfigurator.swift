//
// SDPEncryptionConfigurator.swift
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

        presenter.view = viewController
        presenter.router = router

        let interactor = SDPEncryptionInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
    }
}
