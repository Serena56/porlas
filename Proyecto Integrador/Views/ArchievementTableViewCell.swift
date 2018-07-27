//
//  ArchievementTableViewCell.swift
//  Proyecto Integrador
//
//  Created by Digital House on 26/7/18.
//  Copyright © 2018 Digital House. All rights reserved.
//

import UIKit
import Kingfisher

class ArchievementTableViewCell: UITableViewCell {
    @IBOutlet weak var titleArch: UILabel!
    
    @IBOutlet weak var MedailImage: UIImageView!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(arch: Archievement){
        self.descriptionLabel.text = arch.description
        self.MedailImage.kf.setImage(with: arch.image)
        self.titleArch.text = arch.name
        
    }

}
