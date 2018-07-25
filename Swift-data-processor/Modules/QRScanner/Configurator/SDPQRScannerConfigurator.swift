//
//  DPQRScannerDPQRScannerConfigurator.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 19/07/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit

class SDPQRScannerModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? SDPQRScannerViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: SDPQRScannerViewController) {

        let router = SDPQRScannerRouter()
        router.navigationController = viewController.navigationController

        let presenter = SDPQRScannerPresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = SDPQRScannerInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
    }

}
