//
//  SDPSettingModuleConfigurator.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 12/10/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit

class SDPSettingModuleModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? SDPSettingModuleViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: SDPSettingModuleViewController) {

        let router = SDPSettingModuleRouter()

        let presenter = SDPSettingModulePresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = SDPSettingModuleInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
    }

}
