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
    func updateTheme(theme: SDPApplicationTheme?){
        textView.textColor = theme?.actionColor ?? UIColor(hex:0x177F01)
        textView.borderColor = theme?.actionColor ?? UIColor(hex:0x177F01)
    }
    
    func setupInitialState() {
        textView.addDoneButton()
        textView.text = nil
        textView.delegate = output
        copyButton.isEnabled = false
        pasteButton.isEnabled = UIPasteboard.general.hasStrings
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
        pasteButton.isEnabled = UIPasteboard.general.hasStrings
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
