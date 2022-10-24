//
//  CategoryDetailTableViewCell.swift
//  InternetStore
//
//  Created by Кирилл Зезюков on 12.10.2022.
//

import UIKit

class CategoryDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var textCategoryLabel: UILabel!
    
    //MARK: - Properties
    var category: String = "" {
        didSet {
            categoryButton.setTitle(category + " >", for: .normal) 
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        configureApperance()
    }

    @IBAction func categoryButtonPushed(_ sender: Any) {
        print("Category view!")
    }
    private func configureApperance() {
        selectionStyle = .none
        
        categoryButton.tintColor = .black
        categoryButton.titleLabel?.font = .systemFont(ofSize: 16)
        
        textCategoryLabel.text = "Категория"
        textCategoryLabel.textColor = .gray
        textCategoryLabel.font = .systemFont(ofSize: 10)
    }
    
}
