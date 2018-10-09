//
// SDPRawKeyModuleConfigurator.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 25/09/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit

class SDPRawKeyModuleModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? SDPRawKeyModuleViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: SDPRawKeyModuleViewController) {

        let router = SDPRawKeyModuleRouter()


        let presenter = SDPRawKeyModulePresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = SDPRawKeyModuleInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
    }

}
