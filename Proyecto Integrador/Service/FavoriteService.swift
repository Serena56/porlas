//
//  FavoriteService.swift
//  Proyecto Integrador
//
//  Created by Facun L. on 18/6/18.
//  Copyright © 2018 Digital House. All rights reserved.
//

import Foundation

class FavoriteService {
    
    let daoPelicula = FavoriteDao()
    let daoSerie = FavoriteDao()
    
    func getFavoritesPeliculas () -> [Pelicula] {
        return daoPelicula.getFavoritesPeliculas()
    }
    
    func addFavoritePeliculas(pelicula: Pelicula) {
        daoPelicula.addFavoritePelucula(pelicula: pelicula)
    }
    
    func removeFavoritePeliculas (pelicula: Pelicula) {
        daoPelicula.removeFavoritePelicula(pelicula: pelicula)
    }
    
    func getFavoritesSeries () -> [Serie] {
        return daoSerie.getFavoritesSeries()
    }
    
    func addFavoriteSerie (serie: Serie) {
        daoSerie.addFavoriteSerie(serie: serie)
    }
    
    func removeFavoriteSeries (serie: Serie) {
        daoSerie.removeFavoriteSerie(serie: serie)
    }
    
}

