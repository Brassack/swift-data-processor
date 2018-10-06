//
// SDPEscapingModuleConfigurator.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 03/10/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit

class SDPEscapingModuleModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? SDPEscapingModuleViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: SDPEscapingModuleViewController) {

        let router = SDPEscapingModuleRouter()

        let presenter = SDPEscapingModulePresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = SDPEscapingModuleInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
    }

}
