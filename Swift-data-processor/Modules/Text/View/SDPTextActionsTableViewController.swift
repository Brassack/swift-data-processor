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

    private var dataSource: SDPSingleSectionTableDataSourceObject<String, String>?
    
    var enabled: Bool = false
    
    //MARK: lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Navigation
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.size.height/CGFloat(tableView.numberOfRows(inSection: 0))
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.numberOfRows() ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = dataSource?.element(forRow: indexPath.row).value ?? dataSource?.element(forRow: indexPath.row).element
        
        if enabled{
            cell.textLabel?.textColor = UILabel.appearance(whenContainedInInstancesOf: [UITableViewCell.self]).textColor
        }else{
            cell.textLabel?.textColor = UIColor.lightGray
        }
        
        return cell
    }
    
     override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let element = dataSource?.element(forRow: indexPath.row).element else {
            return
        }
        output.selectAction(element)
    }
    
    //MARK:DPTextActionsViewInput
    func set(tableViewDataSource:SDPSingleSectionTableDataSourceObject<String, String>){
        dataSource = tableViewDataSource
        tableView.reloadSections(IndexSet(integer:0), with: .fade)
    }
    
    func enable() {
        guard !enabled else {
            return
        }
        
        enabled = true
        
        tableView.reloadSections(IndexSet(integer:0), with: .fade)
    }
    
    func disable() {
        guard enabled else{
            return
        }
        
        enabled = false
        
        tableView.reloadSections(IndexSet(integer:0), with: .fade)
    }
    
}
