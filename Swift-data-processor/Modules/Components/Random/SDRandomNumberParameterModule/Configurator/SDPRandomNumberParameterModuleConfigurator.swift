//
//  SDPRandomNumberParameterModuleConfigurator.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 10/10/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit

class SDPRandomNumberParameterModuleModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? SDPRandomNumberParameterModuleViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: SDPRandomNumberParameterModuleViewController) {

        let router = SDPRandomNumberParameterModuleRouter()

        let presenter = SDPRandomNumberParameterModulePresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = SDPRandomNumberParameterModuleInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
    }

}
