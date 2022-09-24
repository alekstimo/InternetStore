//
//  TabBarModelUser.swift
//  InternetStore
//
//  Created by Кирилл Зезюков on 24.09.2022.
//
import Foundation
import UIKit

enum TabBarModelUser {
    case main
    case cart
    case profile
    
    var title: String{
        switch self {
        case .main:
            return "Главная"
        case .cart:
            return "Корзина"
        case .profile:
            return "Профиль"
        }
    }
    
    var image: UIImage? {
        switch self {
        case .main:
            return resizeImage(image: UIImage(named: "mainBar")!, targetSize: CGSize.init(width: 32, height: 32))
        case .cart:
            return resizeImage(image: UIImage(named: "cartBar")!, targetSize: CGSize.init(width: 32, height: 32))
        case .profile:
            return resizeImage(image: UIImage(named: "profileBar")!, targetSize: CGSize.init(width: 32, height: 32))
        }
    }
    var selectedImage: UIImage? {
        return image
    }
}

func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
    let size = image.size

    let widthRatio  = targetSize.width  / image.size.width
    let heightRatio = targetSize.height / image.size.height

    // Figure out what our orientation is, and use that to form the rectangle
    var newSize: CGSize
    if(widthRatio > heightRatio) {
        newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
    } else {
        newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
    }

    // This is the rect that we've calculated out and this is what is actually used below
    let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

    // Actually do the resizing to the rect using the ImageContext stuff
    UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
    image.draw(in: rect)
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()

    return newImage!
}
