//
// SDPHashesConfigurator.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 31/07/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit

class SDPHashesModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? SDPHashesViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: SDPHashesViewController) {

        let router = SDPHashesRouter()

        let presenter = SDPHashesPresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = SDPHashesInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
    }

}
