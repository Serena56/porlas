//
//  SearchViewController.swift
//  Proyecto Integrador
//
//  Created by Digital House on 4/7/18.
//  Copyright © 2018 Digital House. All rights reserved.
//

import UIKit
import FirebaseUI

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MainSerieTableViewCellDelegate, MainPeliculaTableViewCellDelegate {
    
    func didUpdateFavorite(serie: Serie) {
        serie.isFavorite = !serie.isFavorite
        
        let service = FavoriteService()
        if serie.isFavorite {
            service.addFavoriteSerie(serie: serie)
        }
        else {
            service.removeFavoriteSeries(serie: serie)
        }
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
    }
    
    @IBAction func logoutButtomBar(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
        } catch {}
        
        dismiss(animated: true, completion: nil)
    }
    
    
    var ArraySeries:[Serie] = []
    var ArrayMovies:[Pelicula] = []
    var estado: Int = 3
    
    let selectedMovie = 0
    let selectedSerie = 1
    
    var selectedSegment: Int = -1
   
    @IBAction func changeSearchControl(_ sender: Any) {
        searchTapped(sender)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        selectedSegment = self.searchControl.selectedSegmentIndex
        if selectedSegment == selectedMovie {
            return ArrayMovies.count
        }
        if selectedSegment == selectedSerie {
            return ArraySeries.count
        }
            return 0
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedSegment = self.searchControl.selectedSegmentIndex
        
        
        if selectedSegment == selectedMovie {
            performSegue(withIdentifier: "detailMovieSegue", sender: self)
        }
        
        if selectedSegment == selectedSerie {
            performSegue(withIdentifier: "detailSerieSegue", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailPeliculaViewController {
            if let index = searchTableView.indexPathForSelectedRow {
                destination.peliculaSeleccionada = ArrayMovies[index.row]
                destination.delegateDetailPelicula = self
            }
        }
        if let destination = segue.destination as? DetailSeriesViewController {
            if let index = searchTableView.indexPathForSelectedRow {
                destination.serieSeleccionada = ArraySeries[index.row]
                destination.delegateDetailSerie = self
            }
        }
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath)
        
        if let celdaSeleccionada = cell as? SearchTableViewCell {
            if self.estado == 0 {
                celdaSeleccionada.resultado = ArrayMovies[indexPath.row]
                celdaSeleccionada.setup()
                
            }
            
            if self.estado == 1 {
                celdaSeleccionada.resultado = ArraySeries[indexPath.row]
                celdaSeleccionada.setup()
            }

        }
        
        return cell
    }
    
    
    

    @IBAction func searchTapped(_ sender: Any) {
        
        self.estado = self.searchControl.selectedSegmentIndex
        
        if self.estado == 0 {
            let service = MovieService()
            if let queryV = queryField.text {
                if queryV.count > 0 {
                    let adaptedQuery = queryV.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil)
                    service.searchWithQuery(query: adaptedQuery){ (resultados) in
                    self.ArrayMovies = resultados
                    self.searchTableView.reloadData()
                    }
                }
            }
        }
        if self.estado == 1{
            let service = SerieService()
            if let queryV = queryField.text {
                if queryV.count > 0 {
                    let adaptedQuery = queryV.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil)
                    service.searchWithQuery(query: adaptedQuery){ (resultados) in
                        self.ArraySeries = resultados
                        self.searchTableView.reloadData()
                    }
                }
            }
        }
    }
    
   
    
    
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var queryField: UITextField!
    @IBOutlet weak var searchControl: UISegmentedControl!
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchTableView.delegate = self
        self.searchTableView.dataSource = self
        self.searchTableView.rowHeight = 200
 
        queryField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    @objc func textFieldDidChange(){
        self.estado = self.searchControl.selectedSegmentIndex
        
        if self.estado == 0 {
            let service = MovieService()
            if let queryV = queryField.text {
                if !queryV.isEmpty {
                    let adaptedQuery = queryV.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil)
                    service.searchWithQuery(query: adaptedQuery){ (resultados) in
                        self.ArrayMovies = resultados
                        self.searchTableView.reloadData()
                    }
                }
            }
        }
        if self.estado == 1{
            let service = SerieService()
            if let queryV = queryField.text {
                if !queryV.isEmpty {
                    let adaptedQuery = queryV.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil)
                    service.searchWithQuery(query: adaptedQuery){ (resultados) in
                        self.ArraySeries = resultados
                        self.searchTableView.reloadData()
                    }
                }
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}
