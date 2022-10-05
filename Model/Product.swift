//
//  Product.swift
//  InternetStore
//
//
//

import Foundation
//import Firebase
import RealmSwift

class Product: Object {
        
    @objc dynamic var productKey = ""
    @objc dynamic var productInfo = ""
    @objc dynamic var productTitle = ""
    @objc dynamic var productPictureUrl = ""
    @objc dynamic var category: Category!
    @objc dynamic var provider: Provider!
    @objc dynamic var productPrice = 0.0
    
}
