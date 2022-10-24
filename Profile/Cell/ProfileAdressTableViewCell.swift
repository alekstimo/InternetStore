//
//  ProfileAdressTableViewCell.swift
//  InternetStore
//
//  Created by Кирилл Зезюков on 12.10.2022.
//

import UIKit

class ProfileAdressTableViewCell: UITableViewCell {

    @IBOutlet weak var adressLabel: UILabel!
    @IBOutlet weak var textAdressLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        configureApperance()
    }

    var adress: String = " " {
        didSet {
            adressLabel.text = adress
        }
    }
    private func configureApperance(){
        
        selectionStyle = .none
        
        adressLabel.textColor = .black
        adressLabel.font = .systemFont(ofSize: 16)
        
        textAdressLabel.text = "Адрес"
        textAdressLabel.font = .systemFont(ofSize: 10)
        textAdressLabel.textColor = .gray
        
    }
    
}
