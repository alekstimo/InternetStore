//
//  User.swift
//  InternetStore
//
//  Created by Кирилл Зезюков on 30.09.2022.
//

import Foundation
import RealmSwift

class User: Object {
    
    @objc dynamic var login = ""
    @objc dynamic var password = ""
    @objc dynamic var adress = ""
    @objc dynamic var name = ""
    @objc dynamic var telephone = ""
    @objc dynamic var photoUrl = ""
    @objc dynamic var role = "user"
}
