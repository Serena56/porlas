//
//  MainTableViewCell.swift
//  Proyecto Integrador
//
//  Created by Facun L. on 4/6/18.
//  Copyright © 2018 Digital House. All rights reserved.
//

import UIKit
import Kingfisher

protocol MainPeliculaTableViewCellDelegate {
    func didUpdateFavorite(pelicula: Pelicula)
}

class MainPeliculaTableViewCell: UITableViewCell {

    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var favoriteButton: UIButton!
    
    @IBAction func favoriteButton(_ sender: UIButton) {
        if let laPelicula = pelicula {
            delegatePelicula?.didUpdateFavorite(pelicula: laPelicula)
        }
    }
    
    var pelicula: Pelicula?
    var urlPoster: URL?
    var delegatePelicula: MainPeliculaTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        titleLabel.sizeToFit()
    }
    
    func setupCell (pelicula: Pelicula, delegate: MainPeliculaTableViewCellDelegate) {
        
        titleLabel.text = pelicula.title
        
        favoriteButton.setTitle(nil, for: .normal)
        
        urlPoster = pelicula.urlImagePoster
        
        if let urlPosterV = self.urlPoster{
            posterImage.kf.setImage(with: urlPosterV)
        }
        
        if pelicula.isFavorite {
            favoriteButton.setImage(UIImage(named: "favoriteOn"), for: UIControlState.normal)
        }
        else {
            favoriteButton.setImage(UIImage(named: "favoriteOff"), for: UIControlState.normal)
        }
        
        titleLabel.textColor = UIColor.white
//        titleLabel.font = UIFont(name: "SF Mono", size: 25)
        
        delegatePelicula = delegate
        self.pelicula = pelicula
    }
}
