//
//  TexSDPTextViewOutput.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 15/07/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//
import UIKit

//TODO: research for purpose removing UIKit
protocol SDPTextViewOutput: UITextViewDelegate {
    
    func viewIsReady()
    func viewWillAppear()
    func prepare(for segue: UIStoryboardSegue, sender: Any?)
    func copy()
    func paste()
    func qr()
    func selectAction(_ action:String)
}
