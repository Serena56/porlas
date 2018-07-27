//
//  DetailViewController.swift
//  Proyecto Integrador
//
//  Created by Serena Dominguez on 4/6/18.
//  Copyright © 2018 Digital House. All rights reserved.
//

import UIKit
import Kingfisher
import YouTubePlayer

class DetailPeliculaViewController: UIViewController {
    
    var peliculaSeleccionada: Pelicula?
    var delegateDetailPelicula: MainPeliculaTableViewCellDelegate?

    

    @IBOutlet weak var backdropImage: UIImageView!
    @IBOutlet weak var favoriteButtonBar: UIBarButtonItem!
    
    @IBAction func favoriteButtonBar(_ sender: UIBarButtonItem) {
        if let laPelicula = peliculaSeleccionada {
            delegateDetailPelicula?.didUpdateFavorite(pelicula: laPelicula)
            
            if laPelicula.isFavorite {
                favoriteButtonBar.image = UIImage(named: "favoriteOn")
            }
            else {
                favoriteButtonBar.image = UIImage(named: "favoriteOff")
            }
        }
    }
    
    @IBOutlet weak var overviewTextView: UITextView!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let laPelicula = peliculaSeleccionada {
            if laPelicula.isFavorite {
                favoriteButtonBar.image = UIImage(named: "favoriteOn")
            } else {
                favoriteButtonBar.image = UIImage(named: "favoriteOff")
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let movieDao = MovieDao()
        
        overviewTextView.isUserInteractionEnabled = false
        overviewTextView.backgroundColor = UIColor(red: 33/255, green: 33/255, blue: 33/255, alpha: 0)
        overviewTextView.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        
        self.title = peliculaSeleccionada?.title
        overviewTextView.text = peliculaSeleccionada?.overview
        overviewTextView.textAlignment = .center
        
        backdropImage.kf.setImage(with: peliculaSeleccionada?.urlImageBackdrop)
        
        if peliculaSeleccionada?.isFavorite == true {
            favoriteButtonBar.image = UIImage(named: "favoriteOn")
        }
        else {
            favoriteButtonBar.image = UIImage(named: "favoriteOff")
        }

        let player = YouTubePlayerView()
        if let theSelectedMovie = peliculaSeleccionada {
            movieDao.getYoutubeUrl(movie: theSelectedMovie) { (url) in
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
        
        
        // action de la foto
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        backdropImage.isUserInteractionEnabled = true
        backdropImage.addGestureRecognizer(tapGestureRecognizer)

    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        performSegue(withIdentifier: "allDetailMovie", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? AllMovieDetailViewController {
            destination.theMovie = peliculaSeleccionada
        }
    }
}
