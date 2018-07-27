//
//  MainTableViewController.swift
//  Proyecto Integrador
//
//  Created by Serena Dominguez on 4/6/18.
//  Copyright © 2018 Digital House. All rights reserved.
//

import UIKit
import FirebaseUI

class MainPeliculaTableViewController: UITableViewController, MainPeliculaTableViewCellDelegate, FUIAuthDelegate {
    
    @IBAction func logoutButtomBar(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
        } catch {}
        
        dismiss(animated: true, completion: nil)
    }
    
    
    func didUpdateFavorite(pelicula: Pelicula) {
        pelicula.isFavorite = !pelicula.isFavorite
        
        let service = FavoriteService()
        if pelicula.isFavorite {
            service.addFavoritePeliculas(pelicula: pelicula)
        }
        else {
            service.removeFavoritePeliculas(pelicula: pelicula)
        }
        
        tableView.reloadData()
    }
    
    
    var peliculasArreglo: [Pelicula] = []
    var moviesWithoutFilters:[Pelicula] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = 200
        
        let service = MovieService()
        service.search(page: 1){(peliculas) in
            self.peliculasArreglo = peliculas
            self.moviesWithoutFilters = peliculas
            self.tableView.reloadData()
            
        }
        
    }
        
        
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tableView.reloadData()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
       
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return peliculasArreglo.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celdaPelicula", for: indexPath)

        if let celdaSeleccionada = cell as? MainPeliculaTableViewCell {
            celdaSeleccionada.setupCell(pelicula: peliculasArreglo[indexPath.row], delegate: self)
        }
        
        if indexPath.row == peliculasArreglo.count - 5 {
            loadNextPage()
        }
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = nil
        cell.selectedBackgroundView = backgroundView
        
        return cell
    }
    
    func loadNextPage() {
        let movieDao = MovieDao()
        movieDao.getMoviesFromApi(page: peliculasArreglo.count) { (movies) in
            self.peliculasArreglo.append(contentsOf: movies)
            self.tableView.reloadData()
        }
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detailIdentifier", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailPeliculaViewController {
            if let index = tableView.indexPathForSelectedRow {
                destination.peliculaSeleccionada = peliculasArreglo[index.row]
                destination.delegateDetailPelicula = self
            }
        }
        
        if let destination = segue.destination as? GendersViewController{
                destination.movieDelegate = self
                destination.estado = "Movies"
            
            }
        }

    
    func applyFilter(newArray:[Pelicula]){
        self.peliculasArreglo = newArray
        self.tableView.reloadData()
    }

    func deleteFilter(){
        self.peliculasArreglo = self.moviesWithoutFilters
        self.tableView.reloadData()
    }
    
}

    
    
    
  

    
    
 


