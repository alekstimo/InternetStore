//
//  UIImageView+ImageLoader.swift
//  InternetStore
//
//  Created by Кирилл Зезюков on 07.10.2022.
//

import Foundation
import UIKit

extension UIImageView {

    func loadImage(from url: URL) {
        ImageLoader().loadImage(from: url) { [weak self] result in
            if case let .success(image) = result {
                DispatchQueue.main.async {
                    self?.image = image
                }
            }
        }
    }

}
