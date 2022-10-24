//
//  InfoDetailTableViewCell.swift
//  InternetStore
//
//  Created by Кирилл Зезюков on 12.10.2022.
//

import UIKit

class InfoDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var infoTextLabel: UILabel!
    
    var text: String? {
        didSet{
            infoTextLabel.text = text
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
       configureApperance()
    }

    private func configureApperance() {
        selectionStyle = .none
        infoTextLabel.font = .systemFont(ofSize: 12, weight: .light)
        
        infoTextLabel.textColor = .black
        infoTextLabel.numberOfLines = 0
    }
    
}
