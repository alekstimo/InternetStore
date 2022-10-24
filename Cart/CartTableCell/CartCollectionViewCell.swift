//
//  CartCollectionViewCell.swift
//  InternetStore
//
//  Created by Кирилл Зезюков on 24.10.2022.
//

import UIKit

class CartCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var selectedButton: UIButton!
    @IBOutlet weak var imageInUrl: UIImageView!
    private var isSelect: Bool = false
    var count = 1
    var price: Double = 0.0
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var priceLabel: UILabel!
    
    
    @IBAction func selectedButtonTouch(_ sender: Any) {
        isSelect = !isSelect
        if isSelect {
            selectedButton.setImage(UIImage(named: "selected"), for: .normal)
        }
        else {
            selectedButton.setImage(UIImage(named: "nSelected"), for: .normal)
        }
        
    }
    
    @IBAction func plusButtonTouch(_ sender: Any) {
        count = count + 1
        countLabel.text = String(count)
        priceLabel.text = String(price*Double(count)) + "0 р."
    }
    @IBAction func minusButtonTouch(_ sender: Any) {
        if count > 1 {
            count = count - 1
            countLabel.text = String(count)
            priceLabel.text = String(price*Double(count)) + "0 р."
        }
    }
    
    //MARK: - properties
    var titleText: String = "" {
        didSet {
            titleLabel.text = titleText
        }
    }
    var select:Bool = false {
        didSet{
            isSelect = select
            if isSelect {
                selectedButton.setImage(UIImage(named: "selected"), for: .normal)
            }
            else {
                selectedButton.setImage(UIImage(named: "nSelected"), for: .normal)
            }
        }
    }
    var imageUrlInString: String = "" {
           didSet {
               guard let url = URL(string: imageUrlInString) else {
                   return
               }
               imageInUrl.loadImage(from: url)
           }
       }
    
    var priceText: Double = 1.0 {
        didSet {
            price = priceText
            priceLabel.text = String(price*Double(count)) + "0 р."
        }

    }
    var countText: Int = 0{
        didSet {
            count = countText
            countLabel.text = String(count)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        configureApperance()
    }



}
private extension CartCollectionViewCell{
    func configureApperance() {
        //priceLabel.text = String(Double(priceLabel.text!)!*Double(countLabel.text!)!) + "0 р."
        countLabel.textColor = .black
        countLabel.font = .systemFont(ofSize: 12)
        
        imageInUrl.layer.cornerRadius = 12
        
        priceLabel.textColor = .black
        priceLabel.font = .systemFont(ofSize: 15)
        
        titleLabel.textColor = .black
        titleLabel.font = .systemFont(ofSize: 15)
        
    }
}
