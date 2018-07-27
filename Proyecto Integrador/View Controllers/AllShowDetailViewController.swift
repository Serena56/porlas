//
//  AllShowDetailViewController.swift
//  Proyecto Integrador
//
//  Created by Facun L. on 23/7/18.
//  Copyright © 2018 Digital House. All rights reserved.
//

import UIKit

class AllShowDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MainSerieTableViewCellDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recomendationShows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celdaSerie", for: indexPath)
        
        if let celdaSeleccionada = cell as? MainSerieTableViewCell {
            celdaSeleccionada.setupCell(serie: recomendationShows[indexPath.row], delegate: self)
        }
        cell.backgroundColor = UIColor(red: 33/255, green: 33/255, blue: 33/255, alpha: 1)
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = nil
        cell.selectedBackgroundView = backgroundView
        
        return cell
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
        headerLabel.text = self.tableView(recomendationTableView, titleForHeaderInSection: section)
        headerLabel.sizeToFit()
        headerView.addSubview(headerLabel)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let title = self.theShow?.title {
            return "You can also find..."
        }
        return "You can also find..."
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detailSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailSeriesViewController {
            if let index = recomendationTableView.indexPathForSelectedRow {
                destination.serieSeleccionada = recomendationShows[index.row]
                destination.delegateDetailSerie = self
            }
        }
    }
    
    func didUpdateFavorite(serie: Serie) {
        serie.isFavorite = !serie.isFavorite
        
        let service = FavoriteService()
        if serie.isFavorite {
            service.addFavoriteSerie(serie: serie)
        }
        else {
            service.removeFavoriteSeries(serie: serie)
        }
        
        self.recomendationTableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        recomendationTableView.reloadData()
    }
    
    @IBOutlet weak var recomendationTableView: UITableView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var popularityLabel: UILabel!
    @IBOutlet weak var voteAvarageLabel: UILabel!
    
    var theShow: Serie?
    var recomendationShows: [Serie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 33/255, green: 33/255, blue: 33/255, alpha: 1)
        
        titleLabel.textColor = UIColor.white
        yearLabel.textColor = UIColor.white
        popularityLabel.textColor = UIColor.white
        voteAvarageLabel.textColor = UIColor.white
        
        let service = SerieService()
        
        if let show = theShow {
            service.serchRecomendations(serie: show, page: 1) { (series) in
                self.recomendationShows = series
                self.recomendationTableView.reloadData()
            }
        }
        
        recomendationTableView.rowHeight = 200
        
        recomendationTableView.dataSource = self
        recomendationTableView.delegate = self
        
        
        if let title = theShow?.title, let year = theShow?.releaseDate, let popularity = theShow?.popularity, let vote = theShow?.voteAvarage {
            titleLabel.text = "Title: \(title)"
            yearLabel.text = "Date: \(year)"
            
            popularityLabel.text = "Popularity: \(popularity)"
            voteAvarageLabel.text = "Vote Average: \(vote)"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}
