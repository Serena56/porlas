//
//  FavoriteDao.swift
//  Proyecto Integrador
//
//  Created by Facun L. on 18/6/18.
//  Copyright © 2018 Digital House. All rights reserved.
//

import Foundation

class FavoriteDao {
    
    static var peliculas : [Pelicula] = []
    static var series: [Serie] = []
    
    func getFavoritesPeliculas() -> [Pelicula] {
        return FavoriteDao.peliculas
    }
    
    func addFavoritePelucula(pelicula: Pelicula){
        FavoriteDao.peliculas.append(pelicula)
    }
    
    func removeFavoritePelicula (pelicula: Pelicula) {
        var indexRemove: Int?
        for i in 0 ..< FavoriteDao.peliculas.count {
            if FavoriteDao.peliculas[i].title == pelicula.title {
                indexRemove = i
                break
            }
        }
        if let index = indexRemove {
            FavoriteDao.peliculas.remove(at: index)
        }
    }
    
    func getFavoritesSeries() -> [Serie] {
        return FavoriteDao.series
    }
    
    func addFavoriteSerie(serie: Serie) {
        FavoriteDao.series.append(serie)
    }
    
    func removeFavoriteSerie (serie: Serie) {
        var indexRemove: Int?
        for i in 0 ..< FavoriteDao.series.count {
            if FavoriteDao.series[i].title == serie.title {
                indexRemove = i
                break
            }
        }
        if let index = indexRemove {
            FavoriteDao.series.remove(at: index)
        }
    }
}
