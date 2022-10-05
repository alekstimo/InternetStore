//
//  DataService.swift
//  InternetStore
//
//

import Foundation
//import Firebase

//let BASE_URL = "https://internet-store-2022-default-rtdb.europe-west1.firebasedatabase.app"
//
//class DataService {
//    static let dataService = DataService()
//
//    private var _BASE_REF = Firebase(url: "\(BASE_URL)")
//    private var _USER_REF = Firebase(url: "\(BASE_URL)/users")
//    private var _CATEGORY_REF = Firebase(url: "\(BASE_URL)/category")
//
//    var BASE_REF: Firebase {
//        return _BASE_REF
//    }
//
//    var USER_REF: Firebase {
//        return _USER_REF
//    }
//
//    var CURRENT_USER_REF: Firebase {
//        let userID = NSUserDefaults.standardUserDefaults().valueForKey("uid") as! String
//
//        let currentUser = Firebase(url: "\(BASE_REF)").childByAppendingPath("users").childByAppendingPath(userID)
//
//        return currentUser!
//    }
//
//    var CATEGORY_REF: Firebase {
//        return _CATEGORY_REF
//    }
//}
