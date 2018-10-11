//
//  SDPRandomStringParameterModuleViewController.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 10/10/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit

class SDPRandomTextParameterModuleViewController: UIViewController, UITableViewDelegate, UITextFieldDelegate, SDPRandomTextParameterModuleViewInput {

    var output: SDPRandomTextParameterModuleViewOutput!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var countTextField: UITextField!
    @IBOutlet weak var countDescriptionLabel: UILabel!
    @IBOutlet weak var countLimitationLabel: UILabel!
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady(tableView: tableView) { (cell, index) in
            
            guard let cell = cell as? (UITableViewCell & SDPTableViewCellConfigurable) else {
                return
            }

            if cell.indexPath?.row == index {
                cell.accessoryType = .checkmark
            }else{
                cell.accessoryType = .none
            }
        }
    }

    // MARK: SDRandomStringParameterModuleViewInput
    func showCountError() {
        
        countTextField.shake()
    }
    
    func setupInitialState() {
        
        countTextField.addDoneButton()
        tableView.tableFooterView = UIView()
    }
    
    func set(tableViewDataSource: SDPOrdinaryTableViewDataSource) {
        
        tableView.dataSource = tableViewDataSource
    }
    
    func set(textInputDescription: String?) {
        
        countDescriptionLabel.text = textInputDescription
    }
    
    func set(count: String) {
        
        countTextField.text = count
    }
    
    func set(limitation: String) {
        
        countLimitationLabel.text = limitation
    }
    
    func set(countInputVisible: Bool) {
        
        countDescriptionLabel.isHidden = !countInputVisible
        countTextField.isHidden = !countInputVisible
        countLimitationLabel.isHidden = !countInputVisible
    }
    
    //MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        output.select(row: indexPath.row)
    }
    
    //MARK: UITextFieldDelegate
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let text = textField.text {
            output.set(count: text)
        }
    }
}
