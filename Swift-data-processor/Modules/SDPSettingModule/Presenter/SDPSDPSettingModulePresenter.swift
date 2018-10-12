//
//  SDPSettingModulePresenter.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 12/10/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//
import UIKit

class SDPSettingModulePresenter:NSObject, SDPSettingModuleModuleInput, SDPSettingModuleViewOutput, SDPSettingModuleInteractorOutput {

    weak var view: SDPSettingModuleViewInput!
    var interactor: SDPSettingModuleInteractorInput!
    var router: SDPSettingModuleRouterInput!
    
    var dataSource: SDPMulticlassTableViewDataSource?
    
    //MARK: SDPSettingModuleViewOutput
    func viewIsReady(tableView: Any) {

        view.setupInitialState()
        guard let tableView = tableView as? UITableView else {
            return
        }
        
        //https://github.com/Brassack/swift-data-processor
        let themeRow = SDPMulticlassTableViewDataSourceRow(identifier: "theme", data: nil)
        let githubRow = SDPMulticlassTableViewDataSourceRow(identifier: "github", data: nil)
        let appStoreRow = SDPMulticlassTableViewDataSourceRow(identifier: "appstore", data: nil)
        let openSourceRow = SDPMulticlassTableViewDataSourceRow(identifier: "credits", data: nil)

        let section = SDPMulticlassTableViewDataSourceSection(identifier: "setting", title: nil, rows: [themeRow, githubRow, appStoreRow, openSourceRow])
        
        dataSource = SDPMulticlassTableViewDataSource(tableView: tableView, data: [section], cellIdentifierFunction: {
            $0[$1.section].rows[$1.row].identifier
        }, cellExternalConfiguratorFunction:nil)

        view.set(dataSource: dataSource)
    }
    
    func select(identifier: String) {
        
        switch identifier {
        case "theme":
            
            let color = (UIApplication.shared.delegate as? AppDelegate)?.configurator.theme.actionColor ?? UIColor(hex:0x177F01)
            
            router.showColorPicker(color: color) {
                if let color = $0 as? UIColor {
                    (UIApplication.shared.delegate as? AppDelegate)?.configurator.configureTheme(actionColor: color)
                }
            }
        case "github":
  
            if let url = URL(string: "https://github.com/Brassack/swift-data-processor"),
                UIApplication.shared.canOpenURL(url) {
                
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        case "appstore":
            //TODO: add appstore when it will be ready
            break
        case "credits":
            
            router.showCredits()
        default:
            break
        }
    }
    
}
