//
//  DetailPurchaseTableViewCell.swift
//  InternetStore
//
//  Created by Кирилл Зезюков on 02.11.2022.
//

import UIKit

class DetailPurchaseTableViewCell: UITableViewCell {

    @IBOutlet weak var imagePurchaseView: UIImageView!
    
    @IBOutlet weak var countTextlabel: UILabel!
   
    @IBOutlet weak var priceTextLabel: UILabel!
    @IBOutlet weak var titleTextLabel: UILabel!
    
    var count = 1
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    var imageUrlInString: String = "" {
           didSet {
               guard let url = URL(string: imageUrlInString) else {
                   return
               }
               imagePurchaseView.loadImage(from: url)
               
           }
       }
    
    var priceText: Double = 1.0 {
        didSet {
//            print(count)
//            print(priceText*Double(count))
            priceTextLabel.text = "Цена: " + String(priceText*Double(count)) + "0 р."
        }

    }
    var countText: Int = 1{
        didSet {
        count = countText
        countTextlabel.text = "Кол-во: " + String(countText)
        }
    }
    
    var title: String = " " {
        didSet {
            titleTextLabel.text = title
        }
    }
    
    
    
}
private extension DetailPurchaseTableViewCell{
    func configureApperance() {
        //priceLabel.text = String(Double(priceLabel.text!)!*Double(countLabel.text!)!) + "0 р."
        countTextlabel.textColor = .black
        countTextlabel.font = .systemFont(ofSize: 12)
        
        imagePurchaseView.layer.cornerRadius = 12
        
        priceTextLabel.textColor = .black
        priceTextLabel.font = .systemFont(ofSize: 15)
        
        titleTextLabel.textColor = .black
        titleTextLabel.font = .systemFont(ofSize: 15)
        
    }
}
