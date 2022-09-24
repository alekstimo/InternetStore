//
//  TabBarConfigurator.swift
//  InternetStore
//
//  Created by Кирилл Зезюков on 24.09.2022.
//

import Foundation
import UIKit

class TabBarUserConfigurator {
    
    // MARK: - Private property
    private let allTab: [TabBarModelUser] = [.main, .cart, .profile]
   
    //MARK: - Internal func
    
    func configure() -> UITabBarController {
        return getTabBarController()
    }
}

private extension TabBarUserConfigurator {
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
    func getCurrentViewController (tab: TabBarModelUser) -> UIViewController{
        switch tab {
        case .main:
            return MainViewController()
        case .cart:
            return CartViewController()
        case .profile:
            return ProfileViewController()
        }
    }
}


//    func getCurrentDivision(controller: UIViewController) -> String{
//        switch controller {
//        case MainViewController():
//            return "Главная"
//        case FavoriteViewController():
//            return "Избранное"
//        case ProfileViewController():
//            return "Профиль"
//        default:
//            return ""
//        }
//    }
    /*
    func isSearchButtonActive(division: String) -> Bool {
        
        switch division {
        case "Профиль":
            return false
        default:
            return true
        }
    }
    
    
    func createTitleView(division: String, center: CGPoint?) -> UIView {
        let view  = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 280, height: 40)
        
        let title = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        title.text = division
        view.backgroundColor = .clear
        
        title.center = center ?? view.center
        
        //title.center = title.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        //title.sizeToFit()
        //title.adjustsFontForContentSizeCategory = true
        //title.adjustsFontSizeToFitWidth = true
        //var frame = title.frame
        //frame = CGRect(x: 140,y: frame.origin.y,width: 280,height: 21)
        //title.frame = frame
        //title.frame = CGRect(x: 166, y: 59, width: 200, height: 21)
        //title.systemLayoutSizeFitting(CGSize(width: 100, height: 21), withHorizontalFittingPriority: UILayoutPriority(rawValue: 100), verticalFittingPriority:  UILayoutPriority(rawValue: 100))
        title.font = UIFont.systemFont(ofSize: 17)
        title.textColor = .black
        view.addSubview(title)
        
        
        
        return view
    }
    
    func createButton(controller: UIViewController, selector: Selector) -> UIBarButtonItem {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "SearchButton"), for: .normal)
        button.tintColor = .black
        button.addTarget(controller, action: selector, for: .touchUpInside)
        
        let menuBarItem = UIBarButtonItem(customView: button)
        return menuBarItem
        
    }
    */
    
    
    //Создать функцию принимающую выбраный раздел? по нему соориентировать наличие кнопки поиска и заголовок раздела, в этой функции сформировать массив элементов для navigation bar после чего помесить их в navigationItem.rightBarButtomItems
//    private func setupView() {
//        createNavigationBar()
//        let searchButton = createButton(selector: #selector(searchButtonTapped) )
//    }
//    func createNavigationBar(division: String ) -> [UIView,UIBarButtonItem] {
//        let title = createTitleView(division: division)
//        let searchButton = createButton(selector: #selector(searchButtonTapped))
//        return [title,searchButton]
//    }
    
//let division = getCurrentDivision(controller: controller)


//            let title = createTitleView(division: tab.title, center: controller.navigationController?.navigationBar.center) //ПОПЛЫЛО
//
//            var selector = #selector(MainViewController.searchButtonTapped)
//            switch tab.title {
//            case "Избранное":
//                selector = #selector(FavoriteViewController.searchButtonTapped)
//            default:
//                selector = #selector(MainViewController.searchButtonTapped)
//            }
//
//            let searchButton = createButton(controller: controller, selector: selector)
//            //selector: #selector(searchButtonTapped)
//            if (isSearchButtonActive(division: tab.title)) {
//                controller.navigationItem.rightBarButtonItem = searchButton
//            }
//            controller.navigationItem.titleView = title

