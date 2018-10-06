//
// SDPHashesViewController.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 31/07/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit

class SDPHashesViewController: UITableViewController, SDPHashesViewInput {
    
    @IBOutlet weak var saltTextField: UITextField!
    @IBOutlet weak var iterationsTextField: UITextField!
    @IBOutlet weak var argon2ParameterButton: UIBarButtonItem!
    
    var output: (SDPHashesViewOutput & UITextFieldDelegate)!
    private var tableViewDataSource: UITableViewDataSource?

    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        
        iterationsTextField.delegate = output
        saltTextField.delegate = output
        
        output.set(iterationsTextFieldTag: iterationsTextField.tag, saltTextFielTag: saltTextField.tag)
        
        output.viewIsReady(tableView: tableView)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        output.viewWillBePresented()
    }
    
    // MARK: User actions
    @IBAction func dice(_ sender: Any) {
        output.generateRandomSalt()
    }
    
    @IBAction func argon2Parameters(_ sender: Any) {
        output.setupArgon2Parameters()
    }
    
    @IBAction func qr(_ sender: Any) {
        output.scanSaltFromQR()
    }
    
    // MARK: SDPHashesViewInput
    func showError(forTextField textField: Any?, fallbackValue: String?) {
        guard let textField = textField as? UITextField else {
            return
        }
        
        textField.text = fallbackValue
        textField.shake()
    }
    
    func setTableDataSource(_ dataSource: UITableViewDataSource) {
        tableViewDataSource = dataSource
        tableView.dataSource = tableViewDataSource
    }
    
    func set(salt: String?) {
        
        saltTextField.text = salt
        refreshSaltActions()
    }
    
    func refreshSaltActions() {
        
        let salt = saltTextField.text ?? ""
        argon2ParameterButton.isEnabled = salt.count > 7
    }
    
    func setupInitialState() {
        
        iterationsTextField.addDoneButton()
        saltTextField.addDoneButton()
    }
    
    func prepareForScreen() {
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        output.shareHash(atIndexPath: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let title = tableView.dataSource?.tableView?(tableView, titleForHeaderInSection: section) else {
            return nil
        }
        
        let label = UILabel()
        label.backgroundColor = UIColor.white
        label.text = title
        label.textColor = UIColor.darkGray
        label.textAlignment = .center
        label.sizeToFit()
        
        return label
    }
}
