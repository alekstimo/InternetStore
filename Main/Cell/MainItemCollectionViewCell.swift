//
//  MainItemCollectionViewCell.swift
//  InternetStore
//
//  Created by Кирилл Зезюков on 07.10.2022.
//

import UIKit

class MainItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        configureApperance()
    }
    
    //MARK: - properties
    var titleText: String = "" {
        didSet {
            title.text = titleText
        }
    }
    
    var imageUrlInString: String = "" {
           didSet {
               guard let url = URL(string: imageUrlInString) else {
                   return
               }
               imageView.loadImage(from: url)
           }
       }
    
    var priceText: String = "" {
        didSet {
            price.text = priceText + "0 р."
        }
        
    }

}
private extension MainItemCollectionViewCell{
    func configureApperance() {
        title.textColor = .black
        title.font = .systemFont(ofSize: 15)
        
        imageView.layer.cornerRadius = 12
        
        price.textColor = .black
        price.font = .systemFont(ofSize: 12)
    }
}
