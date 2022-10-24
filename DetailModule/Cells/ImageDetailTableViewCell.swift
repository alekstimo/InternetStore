//
//  ImageDetailTableViewCell.swift
//  InternetStore
//
//  Created by Кирилл Зезюков on 12.10.2022.
//

import UIKit

class ImageDetailTableViewCell: UITableViewCell {

    //MARK: - View
    @IBOutlet private weak var cornImageView: UIImageView!
    
    //MARK: - Properties
    var imageUrlInString: String = "" {
            didSet {
                guard let url = URL(string: imageUrlInString) else {
                    return
                }
                cornImageView.loadImage(from: url)
            }
        }
    
    //MARK: - UITableViewCell
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        cornImageView.layer.cornerRadius = 12
        cornImageView.contentMode = .scaleAspectFill
    }
    
}
