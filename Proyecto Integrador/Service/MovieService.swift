//
//  MovieService.swift
//  Proyecto Integrador
//
//  Created by Digital House on 4/7/18.
//  Copyright © 2018 Digital House. All rights reserved.
//

import Foundation

class MovieService{
    func search(page: Int, completion: @escaping ([Pelicula]) -> Void){
        let dao = MovieDao()
        
        dao.getMoviesFromApi(page: page){ (peliculas) in
            completion(peliculas)
            
        }
    }
    
    func searchRecomends(page: Int, movie: Pelicula, completion: @escaping([Pelicula]) -> Void) {
        let dao = MovieDao()
        
        dao.getMoviesRecomendations(page: page, movie: movie) { (peliculas) in
            completion(peliculas)
        }
    }
        
        func searchWithQuery(query:String, completion: @escaping ([Pelicula]) -> Void){
            let dao = MovieDao()
            
            dao.getMoviesFromApiForQuery(query: query) { (resultados) in
                completion(resultados)
            }
        }
    
    func getGenders(completion: @escaping ([Gender]) -> Void){
        
        let dao = MovieDao()
        
        dao.getGendersFromApi(){ (genders) in
            completion(genders)
        }
        
    }
    
    func getMoviesForGender(gender: Gender, completion: @escaping ([Pelicula]) -> Void){
        let dao = MovieDao()
        
        dao.getMoviesToGender(genre: gender){ (movies) in
            completion(movies)
        }
    }
    
    
}

