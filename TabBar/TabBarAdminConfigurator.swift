//
//  TabBarAdminConfigurator.swift
//  InternetStore
//
//  Created by Кирилл Зезюков on 24.09.2022.
//

import Foundation
import UIKit

class TabBarAdminConfigurator {
    
    // MARK: - Private property
    private let allTab: [TabBarModelAdmin] = [.main, .product, .profile]
   
    //MARK: - Internal func
    
    func configure() -> UITabBarController {
        return getTabBarController()
    }
}

private extension TabBarAdminConfigurator {
    func getTabBarController() ->UITabBarController {
        let tabBarController = UITabBarController()
        tabBarController.tabBar.tintColor = .black
        tabBarController.tabBar.unselectedItemTintColor = .lightGray
        tabBarController.tabBar.backgroundColor = .white
        tabBarController.viewControllers = getControllers()
        return tabBarController
    }
    
    func getControllers() -> [UIViewController] {
        var viewControllers = [UIViewController]()
        
        allTab.forEach { tab in
            let controller = getCurrentViewController(tab: tab)
            let navigationController = UINavigationController(rootViewController: controller)
           
            let tabBarItem = UITabBarItem(title: tab.title, image: tab.image, selectedImage: tab.selectedImage)
            
            controller.tabBarItem = tabBarItem
            viewControllers.append(navigationController)
        }
        

        return viewControllers
    }
    func getCurrentViewController (tab: TabBarModelAdmin) -> UIViewController{
        switch tab {
        case .main:
            return MainViewController()
        case .product:
            return ProductAddingViewController()
        case .profile:
            return ProfileViewController()
        }
    }
}
