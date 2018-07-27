//
//  MainSeriesTableViewCell.swift
//  Proyecto Integrador
//
//  Created by Digital House on 6/6/18.
//  Copyright © 2018 Digital House. All rights reserved.
//

import UIKit

protocol MainSerieTableViewCellDelegate {
    func didUpdateFavorite(serie: Serie)
}

class MainSerieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var posterImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
 
    @IBOutlet weak var favoriteButton: UIButton!
    
    @IBAction func favoriteButton(_ sender: UIButton) {
        if let laSerie = serie {
            delegateSerie?.didUpdateFavorite(serie: laSerie)
        }
    }
    
    var serie: Serie?
    var urlPoster: URL?
    
    var delegateSerie: MainSerieTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
         titleLabel.sizeToFit()
    }
    
    func setupCell (serie: Serie, delegate: MainSerieTableViewCellDelegate) {
        titleLabel.text = serie.title
        urlPoster = serie.urlImagePoster
        
        if let urlPosterV = self.urlPoster{
            posterImage.kf.setImage(with: urlPosterV)
        }
        
        favoriteButton.setTitle(nil, for: .normal)
        
        if serie.isFavorite {
            favoriteButton.setImage(UIImage(named: "favoriteOn"), for: UIControlState.normal)
        }
        else {
            favoriteButton.setImage(UIImage(named: "favoriteOff"), for: UIControlState.normal)
        }
        
        delegateSerie = delegate
        self.serie = serie
    
        titleLabel.textColor = UIColor.white
//        titleLabel.font = UIFont(name: "Verdana", size: 25)
    }
}
