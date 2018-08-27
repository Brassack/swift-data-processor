//
//  SDPSDPArgon2ParametersPopupSDPSDPArgon2ParametersPopupConfigurator.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 27/08/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit

class SDPArgon2ParametersPopupModuleConfigurator {

    func configureModuleForViewInput(viewInput: Any) {

        if let view = viewInput as? SDPArgon2ParametersPopupView {
            configure(view: view)
        }
    }

    private func configure(view: SDPArgon2ParametersPopupView) {

        let router = SDPArgon2ParametersPopupRouter()

        let presenter = SDPArgon2ParametersPopupPresenter()
        presenter.view = view
        presenter.router = router

        let interactor = SDPArgon2ParametersPopupInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        view.output = presenter
        
        view.setup()
    }

}
