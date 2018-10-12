//
//  SDPLicenceTableViewController.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 10/12/18.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit

class SDPCreditsTableViewController: UITableViewController {

    var data: [[String:String]]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        
        if let path = Bundle.main.path(forResource: "credits", ofType: "plist") {
            data = NSArray(contentsOfFile: path) as? [[String:String]]
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return data?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        if let cell = cell as? SDPCreditsTableViewCell {
            
            cell.selectionStyle = .none
            cell.nameLabel?.text = data?[indexPath.row]["title"]
            cell.licenceLabel?.text = data?[indexPath.row]["licence"]
        }

        return cell
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let path = data?[indexPath.row]["url"],
            let url = URL(string: path),
            UIApplication.shared.canOpenURL(url) {
            
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
