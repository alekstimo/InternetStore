//
//  ProviderTableViewCell.swift
//  InternetStore
//
//  Created by Кирилл Зезюков on 03.10.2022.
//

import UIKit

class ProviderTableViewCell: UITableViewCell {

    @IBOutlet weak var provider: UILabel!
    var text: String = "" {
        didSet {
            provider.text = text
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        configureApperance()
    }
    private func configureApperance() {
        //selectionStyle = .none
        provider.font = .systemFont(ofSize: 18)
        provider.textColor = .black
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
