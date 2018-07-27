//
//  SearchTableViewCell.swift
//  Proyecto Integrador
//
//  Created by Digital House on 4/7/18.
//  Copyright © 2018 Digital House. All rights reserved.
//

import UIKit
import Kingfisher

class SearchTableViewCell: UITableViewCell {
    
    var delegate:UIViewController?
    var resultado:AnyObject?

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var MainImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(){
        if let resultadoPelicula = self.resultado as? Pelicula{
            self.titleLabel.text = resultadoPelicula.title
            let urlPoster = resultadoPelicula.urlImagePoster
            if let urlPosterV = urlPoster{
                MainImage.kf.setImage(with: urlPosterV)
            }
            
        }
        if let resultadoSerie = self.resultado as? Serie{
            self.titleLabel.text = resultadoSerie.title
            let urlPoster = resultadoSerie.urlImagePoster
            if let urlPosterV = urlPoster{
                MainImage.kf.setImage(with: urlPosterV)
            
        }
        
    }

    }
}
