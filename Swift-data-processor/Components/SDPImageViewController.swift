//
//  SDPImageViewController.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 11/6/18.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit

class SDPImageViewController: UIViewController {

    var imageView: UIImageView {
        get{
            return view as! UIImageView
        }
    }
    
    override func loadView() {
        view = UIImageView()
    }
}
