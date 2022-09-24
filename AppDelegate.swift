//
//  AppDelegate.swift
//  InternetStore
//
//  Created by Кирилл Зезюков on 24.09.2022.
//

import UIKit



@main
class AppDelegate: UIResponder, UIApplicationDelegate {

var window: UIWindow?
    
//
//    var tokenStorage: TokenStorage {
//        BaseTokenStorage()
//    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        startApplicationProccess()
        return true
    }
    
    func startApplicationProccess() {
        
        runLaunchScreen()
        
//        if let tokenContainer = try? tokenStorage.getToken(), !tokenContainer.isExpired {
//            goToMain()
//
        goToMain()
            //TODO: - auth
        //}
        
    }
    
    func runLaunchScreen() {
        let launchScreenViewController = UIStoryboard(name: "LaunchScreen", bundle: .main).instantiateInitialViewController()
        window?.rootViewController = launchScreenViewController
    }
    
    func goToMain(){
        DispatchQueue.main.async {
            self.window?.rootViewController = TabBarUserConfigurator().configure()
        }
    
    }



}


