//
//  TabBarModelAdmin.swift
//  InternetStore
//
//  Created by Кирилл Зезюков on 24.09.2022.
//

import Foundation
import UIKit

enum TabBarModelAdmin {
    case main
    case product
    case profile
    
    var title: String{
        switch self {
        case .main:
            return "Главная"
        case .product:
            return "Товар"
        case .profile:
            return "Профиль"
        }
    }
    
    var image: UIImage? {
        switch self {
        case .main:
            return resizeImage(image: UIImage(named: "mainBar")!, targetSize: CGSize.init(width: 32, height: 32))
        case .product:
            return resizeImage(image: UIImage(named: "addproductBar")!, targetSize: CGSize.init(width: 32, height: 32))
        case .profile:
            return resizeImage(image: UIImage(named: "profileBar")!, targetSize: CGSize.init(width: 32, height: 32))
        }
    }
    var selectedImage: UIImage? {
        return image
    }
}

