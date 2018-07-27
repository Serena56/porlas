//
//  FavoritesTableViewCell.swift
//  Proyecto Integrador
//
//  Created by Facun L. on 18/6/18.
//  Copyright © 2018 Digital House. All rights reserved.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell {

    @IBOutlet weak var favoriteButton: UIButton!
    
    @IBAction func favoriteButton(_ sender: Any) {
        if let laSerie = serie {
            delegateSerie?.didUpdateFavorite(serie: laSerie)
        }
        if let laPelicula = pelicula {
            delegatePelicula?.didUpdateFavorite(pelicula: laPelicula)
        }
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    
    
    var pelicula: Pelicula?
    var serie: Serie?
    var urlPoster:URL?
    
    var delegateSerie: MainSerieTableViewCellDelegate?
    var delegatePelicula: MainPeliculaTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    func setupFavoriteCellPelicula (favorito: Pelicula, delegate: MainPeliculaTableViewCellDelegate) {

        nameLabel.text = favorito.title
        
        urlPoster = favorito.urlImagePoster
        
        if let urlPosterV = self.urlPoster{
            posterImage.kf.setImage(with: urlPosterV)
        }
        
        favoriteButton.setTitle(nil, for: .normal)
        
        if favorito.isFavorite {
            favoriteButton.setImage(UIImage(named: "favoriteOn"), for: UIControlState.normal)
        }
        else {
            favoriteButton.setImage(UIImage(named: "favoriteOff"), for: UIControlState.normal)
        }
        
        delegatePelicula = delegate
        self.pelicula = favorito
        
    }
    
    func setupFavoriteCellSerie (favorito: Serie, delegate: MainSerieTableViewCellDelegate) {

        nameLabel.text = favorito.title
        
        urlPoster = favorito.urlImagePoster
        
        if let urlPosterV = self.urlPoster{
            posterImage.kf.setImage(with: urlPosterV)
        }
        
        favoriteButton.setTitle(nil, for: .normal)
        
        if favorito.isFavorite {
            favoriteButton.setImage(UIImage(named: "favoriteOn"), for: UIControlState.normal)
        }
        else {
            favoriteButton.setImage(UIImage(named: "favoriteOff"), for: UIControlState.normal)
        }
        
        delegateSerie = delegate
        self.serie = favorito
        
    }
    

}
