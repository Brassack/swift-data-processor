//
// SDPSaltModuleConfigurator.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 11/09/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit

class SDPSaltModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? SDPSaltModuleViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: SDPSaltModuleViewController) {

        let router = SDPSaltModuleRouter()

        let presenter = SDPSaltModulePresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = SDPSaltModuleInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
    }

}
