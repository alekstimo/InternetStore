//
//  PopOverStatusTableViewCell.swift
//  InternetStore
//
//  Created by Кирилл Зезюков on 23.11.2022.
//

import UIKit

class PopOverStatusTableViewCell: UITableViewCell {

    @IBOutlet weak var statusName: UILabel!
    var text: String = "" {
        didSet {
            statusName.text = text
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureApperance()
    }

    private func configureApperance() {
      //  selectionStyle = .none
        statusName.font = .systemFont(ofSize: 18)
        statusName.textColor = .black
    }
    
}
