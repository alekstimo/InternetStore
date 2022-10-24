//
//  ProfileImageTableViewCell.swift
//  InternetStore
//
//  Created by Кирилл Зезюков on 12.10.2022.
//

import UIKit

class ProfileImageTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    
    var imageUrlInString: String = "" {
           didSet {
               guard let url = URL(string: imageUrlInString) else {
                   return
               }
               profileImage.loadImage(from: url)
           }
       }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureApperance()
    }

   
    
}
//MARK: - Private Methods
private extension ProfileImageTableViewCell {
    func configureApperance() {
        selectionStyle = .none
        
        profileImage?.layer.cornerRadius = 12
        profileImage?.contentMode = .scaleAspectFill
        
    }
}
