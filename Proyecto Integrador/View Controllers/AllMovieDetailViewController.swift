//
//  AllDetailViewController.swift
//  Proyecto Integrador
//
//  Created by Facun L. on 23/7/18.
//  Copyright © 2018 Digital House. All rights reserved.
//

import UIKit

class AllMovieDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MainPeliculaTableViewCellDelegate {
    func didUpdateFavorite(pelicula: Pelicula) {
        pelicula.isFavorite = !pelicula.isFavorite
        
        let service = FavoriteService()
        if pelicula.isFavorite {
            service.addFavoritePeliculas(pelicula: pelicula)
        }
        else {
            service.removeFavoritePeliculas(pelicula: pelicula)
        }
        
        recomendationsTableView.reloadData()
    }
    
    @IBOutlet weak var recomendationsTableView: UITableView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var popularityLabel: UILabel!
    @IBOutlet weak var voteAvarageLabel: UILabel!
    
    
    var theMovie: Pelicula?
    var recomendationMovies: [Pelicula] = []
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        recomendationsTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: "MovieDetailArch")
        
        view.backgroundColor = UIColor(red: 33/255, green: 33/255, blue: 33/255, alpha: 1)
        
        titleLabel.textColor = UIColor.white
        yearLabel.textColor = UIColor.white
        popularityLabel.textColor = UIColor.white
        voteAvarageLabel.textColor = UIColor.white
        
        let service = MovieService()
        
        if let movie = theMovie {
            service.searchRecomends(page: 1, movie: movie) { (movies) in
                self.recomendationMovies = movies
                self.recomendationsTableView.reloadData()
            }
        }
        

        if let title = theMovie?.title, let year = theMovie?.releaseDate, let popularity = theMovie?.popularity, let vote = theMovie?.voteAvarage {
            titleLabel.text = "Title: \(title)"
            yearLabel.text = "Date: \(year)"
            
            popularityLabel.text = "Popularity: \(popularity)"
            voteAvarageLabel.text = "Vote Average: \(vote)"
        }
        
        recomendationsTableView.rowHeight = 200
        
        recomendationsTableView.dataSource = self
        recomendationsTableView.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celdaPelicula", for: indexPath)
        
        if let celdaSeleccionada = cell as? MainPeliculaTableViewCell {
            celdaSeleccionada.setupCell(pelicula: recomendationMovies[indexPath.row], delegate: self)
        }
        cell.backgroundColor = UIColor(red: 33/255, green: 33/255, blue: 33/255, alpha: 1)
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = nil
        cell.selectedBackgroundView = backgroundView
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recomendationMovies.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor(red: 60/255, green: 60/255, blue: 60/255, alpha: 1)
        
        let headerLabel = UILabel()
        
        headerLabel.font = UIFont(name: "Verdana", size: 20)
        headerLabel.textColor = UIColor.white
        headerLabel.text = self.tableView(recomendationsTableView, titleForHeaderInSection: section)
        headerLabel.sizeToFit()
        headerView.addSubview(headerLabel)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let movietitle = self.theMovie?.title {
        return "You can also find..."
        }
        return "You can also find..."
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detailSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailPeliculaViewController {
            if let index = recomendationsTableView.indexPathForSelectedRow {
                destination.peliculaSeleccionada = recomendationMovies[index.row]
                destination.delegateDetailPelicula = self
            }
        }
    }
    
}
