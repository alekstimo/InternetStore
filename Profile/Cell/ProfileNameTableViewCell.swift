//
//  ProfileNameTableViewCell.swift
//  InternetStore
//
//  Created by Кирилл Зезюков on 12.10.2022.
//

import UIKit

class ProfileNameTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileNameTextLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        configureApperance()
    }
    var name: String = " " {
        didSet {
            nameLabel.text = name
        }
    }
    private func configureApperance(){
        
        selectionStyle = .none
        
        nameLabel.textColor = .black
        nameLabel.font = .systemFont(ofSize: 16)
        
        profileNameTextLabel.text = "Имя"
        profileNameTextLabel.font = .systemFont(ofSize: 10)
        profileNameTextLabel.textColor = .gray
        
    }
}
