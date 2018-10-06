//
// SDPPasswordBasedKeyConfigurator.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 11/09/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit

class SDPPasswordBasedKeyModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? SDPPasswordBasedKeyViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: SDPPasswordBasedKeyViewController) {

        let router = SDPPasswordBasedKeyRouter()
        router.componentStoryboard = UIStoryboard.components
        router.actionsStoryboard = UIStoryboard.actions

        let presenter = SDPPasswordBasedKeyPresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = SDPPasswordBasedKeyInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
    }

}
