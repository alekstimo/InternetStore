//
//  DetailModel.swift
//  InternetStore
//
//  Created by Кирилл Зезюков on 07.10.2022.
//

import Foundation
import UIKit

struct DetailModel {
    // MARK: - Internal Properties
    var imageUrlInString: String
    var title: String
        //var isFavorite: Bool
    var info: String
    var price: Double
    var productKey: String
    var category: String
    var provider: String
    
    

        // MARK: - Initialization
    internal init(imageUrlInString: String, title: String, price: Double, info: String, productKey: String, category: String, provider: String) {
            self.imageUrlInString = imageUrlInString
            self.title = title
            self.price = price
            self.info = info
            self.productKey = productKey
            self.category = category
            self.provider = provider
        }
    
    static func createDefault() -> DetailModel {
        .init(
            imageUrlInString: "",//UIImage(named: "FatCat"),
            title: "Толстые коты лечат",
            price: 300.50,
            info: "Ученые из Британии провели исследование, в котором установили, что, чем больше масса вашего котика, тем полезнее его влияние на ваше здоровье.\n \nВ период исследования были изучены 20 толстых котиков, масса которых превышает нормальную для их породы, помимо этого, были опрошены простые прохожие, и у 99 из 100 человек наблюдался выброс серотонина при взаимодействии с этими котярами. \n \nЛюбите котиков и будете счастливы!",
            productKey: "000000",
            category: "Кошки",
            provider: "Вискас")
        }
    
}
