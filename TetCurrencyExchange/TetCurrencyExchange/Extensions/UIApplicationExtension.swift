//
//  UIApplicationExtension.swift
//  Tet Currency
//
//  Created by armands.berzins on 21/08/2019.
//  Copyright © 2019 armandsberzinsdev. All rights reserved.
//

import UIKit

extension UIApplication {
    var topViewController: UIViewController?{
        if keyWindow?.rootViewController == nil{
            return keyWindow?.rootViewController
        }
        
        var pointedViewController = keyWindow?.rootViewController
        
        while  pointedViewController?.presentedViewController != nil {
            switch pointedViewController?.presentedViewController {
            case let navagationController as UINavigationController:
                pointedViewController = navagationController.viewControllers.last
            case let tabBarController as UITabBarController:
                pointedViewController = tabBarController.selectedViewController
            default:
                pointedViewController = pointedViewController?.presentedViewController
            }
        }
        return pointedViewController
    }
}

protocol TopViewControllerGettable  {
    var topViewController: UIViewController? { get }
    var topNavController: UINavigationController? { get }
    var topTabController: UITabBarController? { get }
}

extension TopViewControllerGettable {
    var topViewController: UIViewController? {
        return UIApplication.shared.topViewController
    }
    
    var topNavController: UINavigationController? {
        return UIApplication.shared.topViewController as? UINavigationController
    }
    
    var topTabController: UITabBarController? {
        return UIApplication.shared.topViewController as? UITabBarController
    }
}
