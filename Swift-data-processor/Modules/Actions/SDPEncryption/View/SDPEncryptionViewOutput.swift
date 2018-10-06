//
// SDPEncryptionViewOutput.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 10/09/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit

protocol SDPEncryptionViewOutput {
    
    func viewIsReady()
    func viewWillBePresented()
    func shareResult()
    func set(method: SDPCipherType)
    func set(keySize: Int)
    func pageViewIsready(_ pageViewController: UIPageViewController)
    func didSelectPasswordBased()
    func didSelectRawBased()
}
