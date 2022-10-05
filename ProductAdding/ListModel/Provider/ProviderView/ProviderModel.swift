//
//  ProviderModel.swift
//  InternetStore
//
//  Created by Кирилл Зезюков on 03.10.2022.
//

import Foundation
import RealmSwift

final class ProviderModel {
    
    //MARK: - Events
    
    var didItemsUpdated: (() -> Void)?
    
    //MARK: - Properties
    var items = [String]() {
        didSet {
            didItemsUpdated?()
        }
    }
    let realm = try! Realm()
    lazy var providers: Results<Provider> = { self.realm.objects(Provider.self) }()
    
    func loadCategory() {
        items = []
        for provider in providers {
            items.append(provider.provaiderInfo)
        }
        
    }
}
