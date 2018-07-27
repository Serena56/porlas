//
//  GendersTableViewCell.swift
//  Proyecto Integrador
//
//  Created by Digital House on 19/7/18.
//  Copyright © 2018 Digital House. All rights reserved.
//

import UIKit


class GendersTableViewCell: UITableViewCell {
    
    var delegate:UIViewController?
    var resultado:AnyObject?

    @IBOutlet weak var genderLabel: UILabel!
    
    @IBOutlet weak var genderImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(){
        if let resultadoGender = self.resultado as? Gender{
            self.genderLabel.text = resultadoGender.name
            getImageToGenreFromStorage()
            
        }
    }
    
    
    func getImageToGenreFromStorage() {
        if let resultadoGenre = self.resultado as? Gender {
            let service = GenreService()
            service.getImageToGenreFromStorage(genre: resultadoGenre, completion: { (url) in
                self.genderImage.kf.setImage(with: url)
            })
        }
    }
    
    

}
