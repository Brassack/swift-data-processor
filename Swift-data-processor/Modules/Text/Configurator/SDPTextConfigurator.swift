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

        if let viewController = viewInput as? SDPTextViewController {
            
            let router = SDPTextRouter()
            router.navigationController = viewController.navigationController
            router.mainStoryboard = UIStoryboard.main
            router.accesoryStoryboard = UIStoryboard.accesory
            router.actionsStoryboard = UIStoryboard.actions
            
            let presenter = SDPTextPresenter()
            presenter.view = viewController
            presenter.router = router
            
            let interactor = SDPTextInteractor()
            interactor.output = presenter
            
            presenter.interactor = interactor
            viewController.output = presenter
        }
    }

    func configureActions(actionsInput: UIViewController, withOutput output:SDPTextViewOutput) {

        if let viewController = actionsInput as? SDPTextActionsTableViewController {
            
            viewController.output = output
        }
    }

}
