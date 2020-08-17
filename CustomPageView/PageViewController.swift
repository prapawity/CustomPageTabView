//
//  PageViewController.swift
//  CustomPageView
//
//  Created by Prapawit Patthasirivichot on 17/8/2563 BE.
//  Copyright © 2563 Prapawit Patthasirivichot. All rights reserved.
//

import UIKit
protocol PageViewControllerDelegate {
    func PageViewControllerDelegate(_ newIndex: Int)
}

class PageViewController: UIPageViewController {
    
    var orderedViewControllers: [UIViewController]!
    var pageViewDelegate: PageViewControllerDelegate!
    private var index = 0 {
        didSet {
            if index == orderedViewControllers.count - 1 {
                inverse = true
            } else if index == 0 {
                inverse = false
            }
        }
    }
    private var inverse = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        delegate = self

        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                direction: .forward,
                animated: true,
                completion: nil)
        }
    }
    
    private func selectedIndex(_ newIndex: Int) {
        setViewControllers([orderedViewControllers[newIndex]],
        direction: newIndex < index ? .reverse : .forward,
        animated: true,
        completion: nil)
        index = newIndex
    }
}

extension PageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController), viewControllerIndex - 1 >= 0 else { return nil }
        let previousIndex = viewControllerIndex - 1
        guard orderedViewControllers.count > previousIndex else { return nil }
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController), viewControllerIndex + 1 != orderedViewControllers.count, viewControllerIndex + 1 < orderedViewControllers.count  else { return nil }
        return orderedViewControllers[viewControllerIndex + 1]
    }
    
}

extension PageViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        guard let viewController = pendingViewControllers.first, let newIndex = orderedViewControllers.firstIndex(of: viewController) else { return }
        index = newIndex
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            pageViewDelegate.PageViewControllerDelegate(index)
        }
    }
    
}

extension PageViewController: TabViewDelegate {
    func tabViewDelegate(_ newIndex: Int) {
        selectedIndex(newIndex)
    }
    
    
}
