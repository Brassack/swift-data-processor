//
//  SDPHashesSDPSDPHashesViewController.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 31/07/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit

class SDPHashesViewController: UITableViewController, SDPHashesViewInput, UITextFieldDelegate {

    @IBOutlet weak var saltTextField: UITextField!
    @IBOutlet weak var iterationsTextField: UITextField!
    @IBOutlet weak var argon2ParameterButton: UIBarButtonItem!
    
    @IBOutlet weak var shareButton: UIButton!

    var output: SDPHashesViewOutput!
    private var tableViewDataSource: UITableViewDataSource?

    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
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
    
    @IBAction func share(_ sender: Any) {
        output.shareSalt()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    // MARK: UITextFieldDelegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField === saltTextField {
            return true
        }
        
        if string.rangeOfCharacter(from:  CharacterSet.decimalDigits.inverted) != nil {
            textField.shake()
            return false
        }
        
        let result = ((textField.text ?? "") as NSString).replacingCharacters(in: range, with: string) as String
        
        guard let resultInt = Int(result) else {
            textField.shake()
            return false
        }
        
        guard resultInt > 0, resultInt < 1000 else {
            textField.shake()
            return false
        }
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField === iterationsTextField {
            if let text = textField.text, let iterations = Int(text), iterations > 0 {
                output.set(iterations: iterations)
            }
        }else if textField === saltTextField {
            output.set(salt: textField.text)
        }
    }
    
    // MARK: SDPHashesViewInput
    func hashCopied(at indexPath: IndexPath) {
        
        guard tableView.indexPathsForVisibleRows?.contains(indexPath) ?? false else {
            return
        }
        
        if let cell = tableView.cellForRow(at: indexPath) as? SDPHashTableViewCellInput {
            cell.animateCopy()
        }
    }
    
    func setTableDataSource(_ dataSource: UITableViewDataSource) {
        tableViewDataSource = dataSource
        tableView.dataSource = tableViewDataSource
    }
    
    func set(salt: String?) {
        saltTextField.text = salt
    }
    
    func setupInitialState() {
        
        let button = UIButton(type: .system)
        button.setTitle("DONE", for: .normal)
        button.backgroundColor = UIColor.white
        button.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 45)
        button.addTarget(iterationsTextField, action: #selector(iterationsTextField.resignFirstResponder), for: .touchUpInside)
        iterationsTextField.inputAccessoryView = button
        
        
        let saltDoneButton = UIButton(type: .system)
        saltDoneButton.setTitle("DONE", for: .normal)
        saltDoneButton.backgroundColor = UIColor.white
        saltDoneButton.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 45)
        saltDoneButton.addTarget(saltTextField, action: #selector(saltTextField.resignFirstResponder), for: .touchUpInside)
        saltTextField.inputAccessoryView = saltDoneButton
    }
    
    func prepareForScreen() {
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        output.copyHash(atIndexPath: indexPath)
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
