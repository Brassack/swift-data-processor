//
// SDPQRGeneratorViewController.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 25/07/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit

class SDPQRGeneratorViewController: UIViewController, SDPQRGeneratorViewInput {
    
    var output: SDPQRGeneratorViewOutput!

    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var qrImageView: UIImageView!
    @IBOutlet weak var qrStateLabel: UILabel!
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        output.viewWillBePresented(qrSize: qrImageView.bounds.size)
    }

    @IBAction func share(_ sender: Any) {
        output.share()
    }
    // MARK: SDPQRGeneratorViewInput
    func setupInitialState() {
        
    }
    
    func show(errorMessage: String) {
        qrStateLabel.text = errorMessage
    }
    
    func show(qrImage: UIImage) {
        
        shareButton.isEnabled = true
        qrImageView.isUserInteractionEnabled = true
        
        qrImageView.isHidden = false
        qrImageView.image = qrImage
    }
    
    func prepareFoorScreen() {
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
}
