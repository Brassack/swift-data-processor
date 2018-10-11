//
//  SDPRandomModuleModuleConfigurator.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 09/10/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit

class SDPRandomModuleModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? SDPRandomModuleViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: SDPRandomModuleViewController) {

        let router = SDPRandomModuleRouter()

        let presenter = SDRandomModulePresenter()
        
        let sb = UIStoryboard.randomComponents
        let numberPage = SDRandomModulePresenter.Page(type: .number, factory: {() -> UIViewController? in
            
            return sb.instantiateViewController(withIdentifier: String(describing: SDPRandomNumberParameterModuleViewController.self))
        })
        
        let textPage = SDRandomModulePresenter.Page(type: .text, factory: {() -> UIViewController? in
            
            return sb.instantiateViewController(withIdentifier: String(describing: SDPRandomTextParameterModuleViewController.self))
        })
        
        let binaryPage = SDRandomModulePresenter.Page(type: .binary, factory: {() -> UIViewController? in
            
            return sb.instantiateViewController(withIdentifier: String(describing: SDPRandomBinaryParametersModuleViewController.self))
        })
        
        presenter.pages = [numberPage, textPage, binaryPage]
        presenter.view = viewController
        presenter.router = router

        let interactor = SDRandomModuleInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
    }

}
