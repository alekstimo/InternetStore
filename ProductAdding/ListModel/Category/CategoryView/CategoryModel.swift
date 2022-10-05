//
//  CategoryModel.swift
//  InternetStore
//
//  Created by Кирилл Зезюков on 03.10.2022.
//

import Foundation
import RealmSwift

final class CategoryModel {
    
    //MARK: - Events
    
    var didItemsUpdated: (() -> Void)?
    
    //MARK: - Properties
    var items = [String]() {
        didSet {
            didItemsUpdated?()
        }
    }
    let realm = try! Realm()
    lazy var categories: Results<Category> = { self.realm.objects(Category.self) }()
    
    func loadCategory() {
        items = []
        for category in categories {
            items.append(category.name)
        }
        
    }
}
