//
//  SDPRandomStringParameterModuleConfigurator.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 10/10/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit

class SDPRandomTextParameterModuleModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? SDPRandomTextParameterModuleViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: SDPRandomTextParameterModuleViewController) {

        let router = SDPRandomTextParameterModuleRouter()

        let presenter = SDPRandomTextParameterModulePresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = SDPRandomTextParameterModuleInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
    }

}
