//
//  MainSeriesTableViewController.swift
//  Proyecto Integrador
//
//  Created by Digital House on 6/6/18.
//  Copyright © 2018 Digital House. All rights reserved.
//

import UIKit
import FirebaseUI

class MainSerieTableViewController: UITableViewController, MainSerieTableViewCellDelegate {
    func didUpdateFavorite(serie: Serie) {
        serie.isFavorite = !serie.isFavorite
        
        let service = FavoriteService()
        if serie.isFavorite {
            service.addFavoriteSerie(serie: serie)
        }
        else {
            service.removeFavoriteSeries(serie: serie)
        }
        
        tableView.reloadData()
    }
    
    
    var seriesArreglo: [Serie] = []
    var seriesSinFiltrar:[Serie] = []
    
    
    @IBAction func logoutButtomBar(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
        } catch {}
        
        dismiss(animated: true, completion: nil) 
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        
        tableView.rowHeight = 200
        let service = SerieService()
        service.search(page: 1){(series) in
            
            self.seriesArreglo = series
            self.seriesSinFiltrar = series
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
        
        return seriesArreglo.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celdaSerie", for: indexPath)
        
        if let celdaSeleccionada = cell as? MainSerieTableViewCell {
            celdaSeleccionada.setupCell(serie: seriesArreglo[indexPath.row], delegate: self)
        }
        
        if indexPath.row == seriesArreglo.count - 5 {
            loadNextPage()
        }
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = nil
        cell.selectedBackgroundView = backgroundView
        
        return cell
    }
    
    func loadNextPage() {
        let seriesDao = SerieDao()
        seriesDao.getSeriesFromApi(page: seriesArreglo.count) { (serie) in
            self.seriesArreglo.append(contentsOf: serie)
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }

    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detailIdentifier2", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailSeriesViewController {
            if let index = tableView.indexPathForSelectedRow {
                destination.serieSeleccionada = seriesArreglo[index.row]
                destination.delegateDetailSerie = self
            }
        }
        
        if let destination = segue.destination as? GendersViewController{
            destination.estado = "Series"
            destination.serieDelegate = self
        }
    }
    
  
    
    func applyFilter(newArray:[Serie]){
        self.seriesArreglo = newArray
        self.tableView.reloadData()
    }
    
    func deleteFilter(){
        self.seriesArreglo = self.seriesSinFiltrar
        self.tableView.reloadData()
    }

}
