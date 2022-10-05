//
//  CategoryTableViewCell.swift
//  InternetStore
//
//  Created by Кирилл Зезюков on 03.10.2022.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var categoryName: UILabel!
  
    var text: String = "" {
        didSet {
            categoryName.text = text
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureApperance()
    }

    private func configureApperance() {
      //  selectionStyle = .none
        categoryName.font = .systemFont(ofSize: 18)
        categoryName.textColor = .black
    }
    
}
