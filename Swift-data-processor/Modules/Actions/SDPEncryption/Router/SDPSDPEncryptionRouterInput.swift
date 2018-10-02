//
//  SDPEncryptionSDPSDPEncryptionRouterInput.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 10/09/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit

protocol SDPEncryptionRouterInput {

    func set(page: UIViewController, forPageController: UIPageViewController, direction: UIPageViewControllerNavigationDirection)
    func share(data:Data)
}
