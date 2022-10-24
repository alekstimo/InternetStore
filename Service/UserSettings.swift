//
//  UserSettings.swift
//  InternetStore
//
//  Created by Кирилл Зезюков on 03.10.2022.
//

import Foundation
final class UserSettings {
    
    private enum SettingsKeys: String {
        case userName
        case password
       // case user
    }
    
    static var userName: String! {
        get{
            return UserDefaults.standard.string(forKey: SettingsKeys.userName.rawValue)
        } set {
            let defaults = UserDefaults.standard
            let key = SettingsKeys.userName.rawValue
            if let name = newValue {
                defaults.set(name, forKey: key)
            } else {
                defaults.removeObject(forKey: key)
            }
        }
    }
    
    static var password: String! {
        get{
            return UserDefaults.standard.string(forKey: SettingsKeys.password.rawValue)
        } set {
            let defaults = UserDefaults.standard
            let key = SettingsKeys.password.rawValue
            if let name = newValue {
                defaults.set(name, forKey: key)
            } else {
                defaults.removeObject(forKey: key)
            }
        }
    }
//
//    static var user: User! {
//        get{
//            return UserDefaults.standard.object(forKey: SettingsKeys.user.rawValue) as! User
//        } set {
//            let defaults = UserDefaults.standard
//            let key = SettingsKeys.user.rawValue
//            if let name = newValue {
//                print(name)
//                defaults.setValue(name, forKey: key)
//                defaults.set(name, forKey: key)
//            } else {
//                defaults.removeObject(forKey: key)
//            }
//        }
//    }
}
