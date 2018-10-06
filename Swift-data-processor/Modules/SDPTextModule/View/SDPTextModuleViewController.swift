//
// SDPTextViewController.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 15/07/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit

class SDPTextModuleViewController: UIViewController, SDPTextModuleViewInput {
    
    var output: SDPTextModuleViewOutput!
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var copyButton: UIButton!
    @IBOutlet weak var qrButton: UIButton!
    @IBOutlet weak var pasteButton: UIButton!
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        output.viewWillBePresented()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        output.prepare(for: segue, sender: sender)
    }
    
    // MARK: TextViewInput
    func setupInitialState() {
        
        let button = UIButton(type: .system)
        button.setTitle("DONE", for: .normal)
        button.backgroundColor = UIColor.white
        button.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 45)
        button.addTarget(textView, action: #selector(textView.resignFirstResponder), for: .touchUpInside)
        textView.inputAccessoryView = button
        
        textView.text = nil
        textView.delegate = output
        copyButton.isEnabled = false
        pasteButton.isEnabled = UIPasteboard.general.string != nil
    }
    
    func prepareForScreen() {
        refreshInputActionsState()
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func set(text: String?) {
        textView.text = text
        refreshInputActionsState()
    }
    
    func refreshInputActionsState(){
        copyButton.isEnabled = textView.text.count > 0
        pasteButton.isEnabled = UIPasteboard.general.string != nil
    }
    
    func setClipboard(isEmpty:Bool){
        pasteButton.isEnabled = !isEmpty
    }

    // MARK: User actions
    @IBAction func copyPressed(_ sender: Any) {
        output.copy()
    }
    
    @IBAction func qrPressed(_ sender: Any) {
        output.qr()
    }
    
    @IBAction func pastePressed(_ sender: Any) {
        output.paste()
    }
}
