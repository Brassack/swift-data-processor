//
//  SDPRandomBinaryParametersModuleSDPRandomBinaryParametersModuleConfigurator.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 10/10/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit

class SDPRandomBinaryParametersModuleModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? SDPRandomBinaryParametersModuleViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: SDPRandomBinaryParametersModuleViewController) {

        let router = SDPRandomBinaryParametersModuleRouter()

        let presenter = SDPRandomBinaryParametersModulePresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = SDPRandomBinaryParametersModuleInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
    }

}
