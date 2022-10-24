//
//  AppDelegate.swift
//  InternetStore
//
//  Created by Кирилл Зезюков on 24.09.2022.
//

import UIKit
import RealmSwift

var currentUser = User()

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
var window: UIWindow?
let realm = try! Realm()
lazy var users: Results<User> = { self.realm.objects(User.self) }()
    
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
        //gotoSingUp()
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
            let tmpLogin = UserSettings.userName ?? " "
            let tmpPassword = UserSettings.password ?? " "
            for user in self.users {
                if user.login == tmpLogin && user.password == tmpPassword {
                    currentUser = user
                    if user.role == "admin" {
                        self.window?.rootViewController = TabBarAdminConfigurator().configure()
                        return
                    }
                }
            }
            self.window?.rootViewController = TabBarUserConfigurator().configure()
        }
    
    }

    func gotoSingUp(){
        DispatchQueue.main.async {
            let singUpVC = LaunchViewController()
            self.window?.rootViewController = singUpVC
        }
    }


}


