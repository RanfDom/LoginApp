//
//  PageViewController.swift
//  LoginApp
//
//  Created by Ranferi Dominguez Rios on 26/11/20.
//  Copyright © 2020 Ranferi Dominguez Rios. All rights reserved.
//

import Foundation
import UIKit

class PageViewController: UIPageViewController, LoadableViewController {
    
    static var storyboardFileName: String = "PageViewController"
    
    lazy var orderedViewControllers: [UIViewController] = {
        return [newStepViewController(step: "1"),
                newStepViewController(step: "2"),
                newStepViewController(step: "3")
        ]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
    }
    
    private func newStepViewController(step: String) -> UIViewController {
        let controller = UIStoryboard(name: "PageViewController", bundle: nil).instantiateViewController(identifier: "\(step)ViewController")
        if let finalStepController = controller as? FinalStepViewController {
            finalStepController.delegate = self
        }
        return controller
    }
}

extension PageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex-1
        
        guard previousIndex >= 0 else {
            return orderedViewControllers.last
        }
        
        guard orderedViewControllers.count > previousIndex else { return nil }
        
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else { return nil }
        
        let nextIndex = viewControllerIndex + 1
        guard orderedViewControllers.count != nextIndex else {
            return orderedViewControllers.first
        }
        
        guard orderedViewControllers.count > nextIndex else { return nil }
        
        return orderedViewControllers[nextIndex]
    }

    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return orderedViewControllers.count
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let firstController = viewControllers?.first,
            let firstViewControllerIndex = orderedViewControllers.firstIndex(of: firstController) else {
                return 0
        }
        return firstViewControllerIndex
    }
}

extension PageViewController: FinalStepDelegate {
    func nextControllerPressed() {
        print("Show Next controller")
    }
}
