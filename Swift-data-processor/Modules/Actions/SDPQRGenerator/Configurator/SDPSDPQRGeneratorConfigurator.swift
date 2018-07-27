//
//  SDPSDPQRGeneratorSDPSDPQRGeneratorConfigurator.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 25/07/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit

class SDPQRGeneratorModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? SDPQRGeneratorViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: SDPQRGeneratorViewController) {

        let router = SDPQRGeneratorRouter()
        router.controllerToPresenting = viewController

        let presenter = SDPQRGeneratorPresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = SDPQRGeneratorInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
    }

}
