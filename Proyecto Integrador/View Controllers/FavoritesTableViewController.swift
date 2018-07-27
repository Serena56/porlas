//
//  FavoritesTableViewController.swift
//  Proyecto Integrador
//
//  Created by Facun L. on 18/6/18.
//  Copyright © 2018 Digital House. All rights reserved.
//

import UIKit
import FirebaseUI

class FavoritesTableViewController: UITableViewController, MainSerieTableViewCellDelegate, MainPeliculaTableViewCellDelegate {
    
    func didUpdateFavorite(pelicula: Pelicula) {
        pelicula.isFavorite = !pelicula.isFavorite
        
        FavoriteService().removeFavoritePeliculas(pelicula: pelicula)
        
        self.tableView.reloadData()
    }
    
    func didUpdateFavorite(serie: Serie) {
        serie.isFavorite = !serie.isFavorite
        
        FavoriteService().removeFavoriteSeries(serie: serie)
        
        self.tableView.reloadData()
    }

    var favoritesPeliculas: [Pelicula] = []
    var favoritesSeries: [Serie] = []
    var todosFavoritos = [[], []]
    
    @IBAction func logoutButtomBar(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
        } catch {}
        
        dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 200
        
        let service = FavoriteService()
        favoritesPeliculas = service.getFavoritesPeliculas()
        favoritesSeries = service.getFavoritesSeries()
        
        todosFavoritos = [favoritesPeliculas, favoritesSeries]
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let service = FavoriteService()
        
        favoritesPeliculas = service.getFavoritesPeliculas()
        
        favoritesSeries = service.getFavoritesSeries()
        
        todosFavoritos = [favoritesPeliculas, favoritesSeries]
        
        self.tableView.reloadData()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return todosFavoritos.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todosFavoritos[section].count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath)
        
        
        if let celdaSeleccionada = cell as? FavoritesTableViewCell {
            
            if let peliculaFavorita = todosFavoritos[indexPath.section][indexPath.row] as? Pelicula {
                celdaSeleccionada.setupFavoriteCellPelicula(favorito: peliculaFavorita, delegate: self)
            }
            if let serieFavorita = todosFavoritos[indexPath.section][indexPath.row] as? Serie {
                celdaSeleccionada.setupFavoriteCellSerie(favorito: serieFavorita, delegate: self)
            }
        }

        let backgroundView = UIView()
        backgroundView.backgroundColor = nil
        cell.selectedBackgroundView = backgroundView
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var header: String?
        if section == 0 {
            header = "Peliculas"
        }
        if section == 1 {
            header = "Series"
        }
        
        return header
    }
 
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if todosFavoritos[indexPath.section][indexPath.row] is Pelicula {
            performSegue(withIdentifier: "detallePeliculaFavorito", sender: self)
        }
        if todosFavoritos[indexPath.section][indexPath.row] is Serie {
            performSegue(withIdentifier: "detalleSerieFavorito", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let index = tableView.indexPathForSelectedRow {
            if let laPelicula = todosFavoritos[index.section][index.row] as? Pelicula {
                if let destination = segue.destination as? DetailPeliculaViewController {
                    destination.peliculaSeleccionada = laPelicula
                    destination.delegateDetailPelicula = self
                }
            }
            if let laSerie = todosFavoritos[index.section][index.row] as? Serie {
                if let destination = segue.destination as? DetailSeriesViewController {
                    destination.serieSeleccionada = laSerie
                    destination.delegateDetailSerie = self
                }
            }
        }
    }


}
