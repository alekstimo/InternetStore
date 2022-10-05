//
//  Purchase.swift
//  InternetStore
//
//  Created by Кирилл Зезюков on 30.09.2022.
//

import Foundation
import RealmSwift

class Purchase: Object {
    
    @objc dynamic var product: Product!
    @objc dynamic var user: User!
    @objc dynamic var status: OrderStatus!
    @objc dynamic var count  = 0
    @objc dynamic var price = 0.0
    @objc dynamic var date = NSDate()
    
}
