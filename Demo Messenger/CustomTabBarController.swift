//
//  CustomTabBarController.swift
//  Demo Messenger
//
//  Created by Samarth Paboowal on 15/01/17.
//  Copyright © 2017 Junkie Labs. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        let controller = FriendsController(collectionViewLayout: layout)
        let navController = UINavigationController(rootViewController: controller)
        navController.tabBarItem.title = "Recent"
        navController.tabBarItem.image = UIImage(named: "")
        
        viewControllers = [navController, createCustomTabController(title: "Calls", imageName: ""), createCustomTabController(title: "Groups", imageName: ""), createCustomTabController(title: "People", imageName: ""), createCustomTabController(title: "Settings", imageName: "")]
    }
    
    func createCustomTabController(title: String, imageName: String) -> UINavigationController {
        
        let controller = UIViewController()
        let navController = UINavigationController(rootViewController: controller)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = UIImage(named: imageName)
        
        return navController
    }
}
