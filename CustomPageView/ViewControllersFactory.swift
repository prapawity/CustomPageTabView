//
//  ViewControllersFactory.swift
//  CustomPageView
//
//  Created by Prapawit Patthasirivichot on 17/8/2563 BE.
//  Copyright © 2563 Prapawit Patthasirivichot. All rights reserved.
//

import UIKit

typealias StaticViewControllerFactoryFunction = (() -> UIViewController)

struct ViewControllersFactory {
    
    static let pageViewController: StaticViewControllerFactoryFunction = {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PageView") as! PageViewController
    }
    
    static let firstViewController: StaticViewControllerFactoryFunction = {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "First") as! FirstViewController
    }

    static let secondViewController: StaticViewControllerFactoryFunction = {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Second") as! SecondViewController
    }

    static let thirdViewController: StaticViewControllerFactoryFunction = {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Third") as! ThirdViewController
    }
}
