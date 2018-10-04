//
//  DPTexSDPTextConfigurator.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 15/07/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit

//TODO: research for purpose removing UIKit
class SDPTextModuleConfigurator {

    func configureModuleForViewInput(viewInput: UIViewController) {

        if let viewController = viewInput as? SDPTextModuleViewController {
            
            let router = SDPTextModuleRouter()
            router.navigationController = viewController.navigationController
            router.mainStoryboard = UIStoryboard.main
            router.accesoryStoryboard = UIStoryboard.accesory
            router.actionsStoryboard = UIStoryboard.actions
            
            let presenter = SDPTextModulePresenter()
            presenter.view = viewController
            presenter.router = router
            
            let interactor = SDPTextModuleInteractor()
            interactor.output = presenter
            
            presenter.interactor = interactor
            viewController.output = presenter
        }
    }

    func configureActions(actionsInput: UIViewController, withOutput output:SDPTextModuleViewOutput) {

        if let viewController = actionsInput as? SDPTextModuleActionsTableViewController {
            
            viewController.output = output
        }
    }

}
