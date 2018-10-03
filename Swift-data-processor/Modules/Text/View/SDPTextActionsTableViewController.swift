//
//  TableViewController.swift
//  test
//
//  Created by Dmytro Platov on 2/10/18.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit

class SDPTextActionsTableViewController: UITableViewController, SDPTextActionsViewInput {
    
    var output: SDPTextViewOutput!
    var cellIdentifier: String {
        get{
            return "Cell"
        }
    }
    var cellConfigurator: SDPTableViewCellExternalConfigurator? {
        get{
            return { [weak self] (cell, row) -> Void in
                
                guard let isEnabled = self?.enabled else {
                    return
                }
                
                if isEnabled{
                    cell.textLabel?.textColor = UILabel.appearance(whenContainedInInstancesOf: [UITableViewCell.self]).textColor
                }else{
                    cell.textLabel?.textColor = UIColor.lightGray
                }
            }
        }
    }

    private var dataSource: SDPOrdinaryTableViewDataSource?
    
    var enabled: Bool = false
    
    //MARK: lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Navigation
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.size.height/CGFloat(tableView.numberOfRows(inSection: 0))
    }

     override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        output.selectAction(index: indexPath.row)
    }
    
    //MARK:DPTextActionsViewInput
    func set(tableViewDataSource:SDPOrdinaryTableViewDataSource){
        
        dataSource = tableViewDataSource
        tableView.dataSource = dataSource
        tableView.reloadData()
    }
    
    func enable() {
        guard !enabled else {
            return
        }
        
        enabled = true
        
        tableView.reloadSections(IndexSet(integer:0), with: .fade)
        tableView.isUserInteractionEnabled = true
    }
    
    func disable() {
        guard enabled else{
            return
        }
        
        enabled = false
        
        tableView.reloadSections(IndexSet(integer:0), with: .fade)
        tableView.isUserInteractionEnabled = false
    }
    
}
