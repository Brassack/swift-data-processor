//
//  SDPColorPickerViewController.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 10/12/18.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit
import NKOColorPickerView

//@property (nonatomic, strong) NKOColorPickerDidChangeColorBlock didChangeColorBlock;
//@property (nonatomic, strong) UIColor *color;

class SDPColorPickerViewController: UIViewController {

    fileprivate var _color: UIColor?
    fileprivate var _didChangeColorBlock: NKOColorPickerDidChangeColorBlock?
    
    var color: UIColor? {
        get{
            return colorView?.color ?? _color
        }
        
        set{
            if let colorView = colorView {
                colorView.color = newValue
            }else{
                _color = newValue
            }
        }
    }
    
    var didChangeColorBlock: NKOColorPickerDidChangeColorBlock? {
        get{
            return colorView?.didChangeColorBlock ?? _didChangeColorBlock
        }
        
        set{
            if let colorView = colorView {
                colorView.didChangeColorBlock = newValue
            }else{
                _didChangeColorBlock = didChangeColorBlock
            }
        }
    }

    fileprivate var colorView: NKOColorPickerView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        colorView = NKOColorPickerView()
        
        guard let colorView = colorView else {
            return
        }
        
        colorView.color = _color
        colorView.didChangeColorBlock = _didChangeColorBlock
        
        _color = nil
        _didChangeColorBlock = nil
        
        view.addSubview(colorView)
        
        colorView.translatesAutoresizingMaskIntoConstraints = false

        if #available(iOS 11, *) {
            let guide = view.safeAreaLayoutGuide
            NSLayoutConstraint.activate([
                colorView.topAnchor.constraint(equalToSystemSpacingBelow: guide.topAnchor, multiplier: 1.0),
                guide.bottomAnchor.constraint(equalToSystemSpacingBelow: colorView.bottomAnchor, multiplier: 1.0),
                colorView.leftAnchor.constraint(equalToSystemSpacingAfter: guide.leftAnchor, multiplier: 1.0),
                guide.rightAnchor.constraint(equalToSystemSpacingAfter: colorView.rightAnchor, multiplier: 1.0)
            ])

        } else {
            let standardSpacing: CGFloat = 8.0
            NSLayoutConstraint.activate([
                    colorView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: standardSpacing),
                    bottomLayoutGuide.topAnchor.constraint(equalTo: colorView.bottomAnchor, constant: standardSpacing),
                    colorView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: standardSpacing),
                    view.rightAnchor.constraint(equalTo: colorView.rightAnchor, constant: standardSpacing)
                ])
        }
    }
}
