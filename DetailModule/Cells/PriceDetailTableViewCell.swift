//
//  PriceDetailTableViewCell.swift
//  InternetStore
//
//  Created by Кирилл Зезюков on 12.10.2022.
//

import UIKit

class PriceDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var textKeyLabel: UILabel!
    @IBOutlet weak var keyLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    //MARK: - Properties
    var price: String = "" {
        didSet {
            priceLabel.text = price + "0 р."
        }
    }
    var key: String = "" {
        didSet {
            keyLabel.text = key
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        configureApperance()
    }

    
    private func configureApperance() {
        selectionStyle = .none
        priceLabel.font = .systemFont(ofSize: 16)
        priceLabel.textColor = .black
        keyLabel.font = .systemFont(ofSize: 10)
        keyLabel.textColor = .black
        textKeyLabel.text = "Код товара"
        textKeyLabel.textColor = .gray
        textKeyLabel.font = .systemFont(ofSize: 10)
    }
    
}
