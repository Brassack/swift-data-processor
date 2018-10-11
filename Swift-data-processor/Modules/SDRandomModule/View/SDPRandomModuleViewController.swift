//
//  SDPRandomModuleViewController.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 09/10/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit

class SDPRandomModuleViewController: UIViewController, SDPRandomModuleViewInput {

    var output: SDPRandomModuleViewOutput!    
    @IBOutlet weak var randomTypeSegmentView: UISegmentedControl!

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SDPRandomTypePageControllersContainer" {
            
            output.set(pagesViewController: segue.destination)
        }
    }

    //MARK: User actions
    @IBAction func share(_ sender: Any) {
        output.share()
    }
    
    @IBAction func random(_ sender: Any) {
        output.random()
    }
    
    @IBAction func typeChanged(_ sender: UISegmentedControl) {
        output.set(typeId: sender.selectedSegmentIndex)
    }
    
    // MARK: SDRandomModuleViewInput
    func setupInitialState() {
    }
    
    func set(randomTypes: [String]) {
        
        randomTypeSegmentView.removeAllSegments()
        
        for type in randomTypes.reversed() {
            
            randomTypeSegmentView.insertSegment(withTitle: type, at: 0, animated: false)
        }
        
        randomTypeSegmentView.selectedSegmentIndex = 0
    }
}
