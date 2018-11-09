//
//  SDPWalkthroughModuleSDPSDPWalkthroughModuleViewController.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 05/11/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit

class SDPWalkthroughModuleViewController: UIViewController, SDPWalkthroughModuleViewInput, UIPageViewControllerDelegate {

    var output: SDPWalkthroughModuleViewOutput!
    
    @IBOutlet weak var pagesController: UIPageControl!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    weak var pagesViewController: UIPageViewController?

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }

    // MARK: SDPWalkthroughModuleViewInput
    func setupInitialState() {
    }
    
    func set(pagesDataSource dataSource: SDPPagesControllerDataSource) {
        
        pagesViewController?.dataSource = dataSource
        if let vc = dataSource.viewControllerSource?(0) as? UIViewController {
            pagesViewController?.setViewControllers([vc], direction: .forward, animated: false, completion: nil)
        }
    }
    
    func set(description: String) {
        
        descriptionLabel.text = description
    }
    
    @IBAction func gotIt(_ sender: Any) {
        
        output.dismiss()
    }
    
    // MARK: pages view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        pagesViewController = segue.destination as? UIPageViewController
        pagesViewController?.delegate = self
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        output.set(pageIndex: pageViewController.viewControllers?.first?.view.tag ?? 0)
    }
}
