//
//  SerieService.swift
//  Proyecto Integrador
//
//  Created by Digital House on 4/7/18.
//  Copyright © 2018 Digital House. All rights reserved.
//

import Foundation
class SerieService {
    
    func search(page: Int, completion: @escaping ([Serie]) -> Void){
        let dao = SerieDao()
        
        dao.getSeriesFromApi(page: page){ (series) in
            completion(series)
            
        }
        
    }
    
    func serchRecomendations(serie: Serie, page: Int, completion: @escaping ([Serie]) -> Void) {
        let dao = SerieDao()
        
        dao.getSeriesRecomendatins(serie: serie, page: 1) { (series) in
            completion(series)
        }
    }
    
    func searchWithQuery(query:String, completion: @escaping ([Serie]) -> Void){
        let dao = SerieDao()
        
        dao.getSerieFromApiForQuery(query: query) { (resultados) in
            completion(resultados)
        }
    }
    
    
    func getGenders(completion: @escaping ([Gender]) -> Void){
        
        let dao = SerieDao()
        
        dao.getGendersFromApi(){ (genders) in
            completion(genders)
        }
        
    }
    
    func getSeriesForGenre(genre: Gender, completion: @escaping ([Serie]) -> Void){
        let dao = SerieDao()
        
        dao.getSeriesToGenre(genre: genre){ (series) in
            completion(series)
        }
    }
    
//    func getTrailerToSerieFromApi(serie: Serie, completion: @escaping (String) -> Void) {
//
//        let dao = SerieDao()
////        dao.getTrailerToSerieFromApi(serie: serie) { (url) in
////            completion(url)
////        }
//
//
//    }
    
    
}
