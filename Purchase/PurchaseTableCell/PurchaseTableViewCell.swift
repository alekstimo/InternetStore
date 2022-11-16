//
//  PurchaseTableViewCell.swift
//  InternetStore
//
//  Created by Кирилл Зезюков on 02.11.2022.
//

import UIKit

class PurchaseTableViewCell: UITableViewCell {

    @IBOutlet weak var sumTextLabel: UILabel!
    @IBOutlet weak var purcaheTextLabel: UILabel!
    
    //MARK: - properties
    var purcahesDate: String = "" {
        didSet {
            purcaheTextLabel.text = "Заказ от " + purcahesDate
        }
    }
    var sum: String = "" {
        didSet {
            sumTextLabel.text = "Сумма: " + sum
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        sumTextLabel.textColor = .black
        sumTextLabel.font = .systemFont(ofSize: 15)
        
        purcaheTextLabel.textColor = .black
        purcaheTextLabel.font = .systemFont(ofSize: 15)
    }

   
    
}
