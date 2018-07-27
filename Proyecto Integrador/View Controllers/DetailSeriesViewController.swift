//
//  DetailSeriesViewController.swift
//  Proyecto Integrador
//
//  Created by Digital House on 6/6/18.
//  Copyright © 2018 Digital House. All rights reserved.
//

import UIKit
import Kingfisher
import YouTubePlayer
import Alamofire


class DetailSeriesViewController: UIViewController {
    
    var serieSeleccionada: Serie?
    var delegateDetailSerie: MainSerieTableViewCellDelegate?

    
    @IBOutlet weak var favoriteButtonBar: UIBarButtonItem!
  
    
    @IBAction func favoriteButtonBar(_ sender: UIBarButtonItem) {
        if let laSerie = serieSeleccionada {
            delegateDetailSerie?.didUpdateFavorite(serie: laSerie)
            
            if laSerie.isFavorite {
                favoriteButtonBar.image = UIImage(named: "favoriteOn")
            }
            else {
                favoriteButtonBar.image = UIImage(named: "favoriteOff")
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let laSerie = serieSeleccionada {
            if laSerie.isFavorite {
                favoriteButtonBar.image = UIImage(named: "favoriteOn")
            } else {
                favoriteButtonBar.image = UIImage(named: "favoriteOff")
            }
        }
        
        
    }
    
    
    @IBOutlet weak var backdropImage: UIImageView!
   
    
    @IBOutlet weak var overviewTextView: UITextView!
    
     @IBOutlet weak var popularityLabel: UILabel!
     @IBOutlet weak var voteAvarageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: "DetailSerieArch")
        
        overviewTextView.backgroundColor = UIColor(red: 33/255, green: 33/255, blue: 33/255, alpha: 0)
        overviewTextView.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        overviewTextView.textAlignment = .center
        
        let serieDao = SerieDao()
        
        self.title = serieSeleccionada?.title
        

        overviewTextView.text = serieSeleccionada?.overview
        overviewTextView.isUserInteractionEnabled = false
        backdropImage.kf.setImage(with: serieSeleccionada?.urlImageBackdrop)
     
        if serieSeleccionada?.isFavorite == true {
            favoriteButtonBar.image = UIImage(named: "favoriteOn")
        }
        else {
            favoriteButtonBar.image = UIImage(named: "favoriteOff")
        }
        
        let player = YouTubePlayerView()
        if let theSelectedShow = serieSeleccionada {
            serieDao.getYoutubeUrl(serie: theSelectedShow) { (url) in
                player.loadVideoURL(url)
            }
        }
        player.play()
        self.view.addSubview(player)
        self.view.addSubview(overviewTextView)
        
        // como se agrego el todo lo respecot al video por codigo, configuro los contraints por codigo
        player.translatesAutoresizingMaskIntoConstraints = false
        
        let leadingPlayer = NSLayoutConstraint(item: player, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 20)
        let topPlayer = NSLayoutConstraint(item: player, attribute: .top, relatedBy: .equal, toItem: overviewTextView, attribute: .bottom, multiplier: 1, constant: 40)
        let trailingPlayer = NSLayoutConstraint(item: player, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: -20)
        let bottomPlayer = NSLayoutConstraint(item: player, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: -60)
        view.addConstraints([leadingPlayer, topPlayer, trailingPlayer, bottomPlayer])
        
        // action de la imagen
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        backdropImage.isUserInteractionEnabled = true
        backdropImage.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        performSegue(withIdentifier: "showAllDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? AllShowDetailViewController {
            destination.theShow = serieSeleccionada
        }
    }

}
