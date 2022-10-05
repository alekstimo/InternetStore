//
//  ProviderAddTableViewCell.swift
//  InternetStore
//
//  Created by Кирилл Зезюков on 03.10.2022.
//

import UIKit
import RealmSwift
class ProviderAddTableViewCell: UITableViewCell {
    let realm = try! Realm()
    override func awakeFromNib() {
        super.awakeFromNib()
  //      configureApperance()
    }
    @IBOutlet weak var providerAddTextField: UITextField!
    
    @IBAction func ProviderAdd(_ sender: Any) {
        let providerText = providerAddTextField.text ?? ""
        if !providerText.isEmpty {
            try! realm.write() {
            let provider = Provider(value: [providerText])
            self.realm.add(provider)
            }
        }
        providerAddTextField.text?.removeAll()
    }
    private func configureApperance() {
        selectionStyle = .none
        providerAddTextField.setValue(UIFont.systemFont(ofSize: 18),forKeyPath: "_placeholderLabel.font")
        providerAddTextField.setValue(UIFont.systemFont(ofSize: 18), forKeyPath: "_placeholderLabel.textColor")
//        providerAddTextField.setValue(UIFont.systemFont(ofSize: 18),forKeyPath: "_textLabel.font")
//        providerAddTextField.setValue(UIFont.systemFont(ofSize: 18), forKeyPath: "_textLabel.textColor")
    }
    
}
