//
//  SDPHashesSDPSDPHashesViewOutput.swift
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
    
//    func set(iterations: Int)
//    func set(salt: String?)
    func generateRandomSalt()
    func shareSalt()
    func scanSaltFromQR()
    func setupArgon2Parameters()
    
    func copyHash(atIndexPath indexPath: IndexPath)
}
