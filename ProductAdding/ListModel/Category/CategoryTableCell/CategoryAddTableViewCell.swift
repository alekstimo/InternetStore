//
//  CategoryAddTableViewCell.swift
//  InternetStore
//
//  Created by Кирилл Зезюков on 03.10.2022.
//

import UIKit
import RealmSwift
class CategoryAddTableViewCell: UITableViewCell {

    let realm = try! Realm()
    @IBOutlet weak var categoryAddTextField: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func categoryAdd(_ sender: Any) {
        let categoryText = categoryAddTextField.text ?? ""
        if !categoryText.isEmpty {
            try! realm.write() {
            let category = Category(value: [categoryText])
            self.realm.add(category)
            }
        }
        categoryAddTextField.text?.removeAll()
    }
  
    
}
