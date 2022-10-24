//
//  ProviderDetailTableViewCell.swift
//  InternetStore
//
//  Created by Кирилл Зезюков on 12.10.2022.
//

import UIKit

class ProviderDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var providerButton: UIButton!
    @IBOutlet weak var providerTextLabel: UILabel!
    
    //MARK: - Properties
    var provider: String = "" {
        didSet {
            providerButton.setTitle(provider + " >", for: .normal) 
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureApperance()
    }

    @IBAction func providerButtonPushed(_ sender: Any) {
        print("Provider productView!")
    }
    private func configureApperance() {
        selectionStyle = .none
        
        providerButton.tintColor = .black
        providerButton.titleLabel?.font = .systemFont(ofSize: 16)
        
        
        providerTextLabel.text = "Бренд"
        providerTextLabel.textColor = .gray
        providerTextLabel.font = .systemFont(ofSize: 10)
    }
    
}
