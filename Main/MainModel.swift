//
//  MainModel.swift
//  InternetStore
//
//  Created by Кирилл Зезюков on 07.10.2022.
//

import Foundation
import UIKit
import SwiftUI
import RealmSwift

final class MainModel {
    
    //MARK: - Events
    
    var didItemsUpdated: (() -> Void)?
    
    //MARK: - Properties
    var items = [DetailModel]() {
        didSet {
            didItemsUpdated?()
        }
    }
    let realm = try! Realm()
    lazy var products: Results<Product> = { self.realm.objects(Product.self) }()
    
    func loadPosts() {
        items = []
        for product in products {
            items.append(DetailModel(
                imageUrlInString: product.productPictureUrl,
                title: product.productTitle,
                price: product.productPrice,
                info: product.productInfo,
                productKey: product.productKey,
                category: product.category.name,
                provider: product.provider.provaiderInfo))
        }
        
    }
}

