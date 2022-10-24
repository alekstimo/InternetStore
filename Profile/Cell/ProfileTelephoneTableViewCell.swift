//
//  ProfileTelephoneTableViewCell.swift
//  InternetStore
//
//  Created by Кирилл Зезюков on 12.10.2022.
//

import UIKit

class ProfileTelephoneTableViewCell: UITableViewCell {

    @IBOutlet weak var telephoneLabel: UILabel!
    @IBOutlet weak var textTelephoneLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        configureApperance()
    }
    var telephone: String = " " {
        didSet {
            telephoneLabel.text = telephone
        }
    }
    private func configureApperance(){
        
        selectionStyle = .none
        
        telephoneLabel.textColor = .black
        telephoneLabel.font = .systemFont(ofSize: 16)
        
        textTelephoneLabel.text = "Телефон"
        textTelephoneLabel.font = .systemFont(ofSize: 10)
        textTelephoneLabel.textColor = .gray
        
    }
}
