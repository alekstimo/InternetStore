//
//  TitleDetailTableViewCell.swift
//  InternetStore
//
//  Created by Кирилл Зезюков on 12.10.2022.
//

import UIKit

class TitleDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var TitleLabel: UILabel!
    
    //MARK: - Properties
    var title: String = "" {
        didSet {
            TitleLabel.text = title
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        configureApperance()
    }

    private func configureApperance() {
        selectionStyle = .none
        TitleLabel.font = .systemFont(ofSize: 16)
        TitleLabel.textColor = .black
        
    }
}
    

