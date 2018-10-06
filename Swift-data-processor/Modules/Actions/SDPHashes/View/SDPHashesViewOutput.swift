//
// SDPHashesViewOutput.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 31/07/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit

protocol SDPHashesViewOutput {

    func viewIsReady(tableView: UITableView)
    func viewWillBePresented()
    func set(iterationsTextFieldTag: Int, saltTextFielTag: Int)
    
    func generateRandomSalt()
    func scanSaltFromQR()
    func setupArgon2Parameters()
    
    func shareHash(atIndexPath indexPath: IndexPath)
}
