//
//  SerieDao.swift
//  Proyecto Integrador
//
//  Created by Digital House on 4/7/18.
//  Copyright © 2018 Digital House. All rights reserved.
//

import Foundation
import Alamofire
import FirebaseStorage

class SerieDao{
    
    func getSeriesFromApi(page: Int, completion: @escaping([Serie]) -> Void){
        let popularUrl = MovieHelper.getTVPopular(language: MovieHelper.language_ENGLISH, page: page)
        print(popularUrl)
        Alamofire.request(popularUrl).responseJSON{(response) in
            if let mainDictionary = response.result.value as? [String:AnyObject]{
                if let results = mainDictionary["results"] as? [[String:AnyObject]]{
                    var seriesArray:[Serie] = []
                    for aDictionary in results{
                        let newSerie = Serie(dictionary: aDictionary)
                        seriesArray.append(newSerie)
                    }
                    
                    completion(seriesArray)
                } else {
                    completion([])
                }
                
            }
        }
    }
    
    func getSeriesRecomendatins(serie: Serie, page: Int, completion: @escaping([Serie]) -> Void){
        if let serieId = serie.id {
            let popularUrl = "https://api.themoviedb.org/3/tv/\(serieId)/similar?api_key=db898f2be5d80aee6fee0407b549ec39&language=en-US&page=1"
            Alamofire.request(popularUrl).responseJSON{(response) in
                if let mainDictionary = response.result.value as? [String:AnyObject]{
                    if let results = mainDictionary["results"] as? [[String:AnyObject]]{
                        var seriesArray:[Serie] = []
                        for aDictionary in results{
                            let newSerie = Serie(dictionary: aDictionary)
                            seriesArray.append(newSerie)
                        }
                        
                        completion(seriesArray)
                    } else {
                        completion([])
                    }
                    
                }
            }
        }
    }
    
    
    
    func getYoutubeUrl (serie: Serie, completion: @escaping (URL) -> Void) {
        if let serieId = serie.id {
            print(serieId)
            let youTubeLink = "https://www.youtube.com/watch?v="
            let videoData = "https://api.themoviedb.org/3/tv/\(serieId)/videos?api_key=db898f2be5d80aee6fee0407b549ec39&language=en-US&page=1"
            
            Alamofire.request(videoData).responseJSON { (response) in
                if let dictionary = response.result.value as? [String: AnyObject] {
                    if let results = dictionary["results"] as? [[String: AnyObject]] {
                        if results.isEmpty == false {
                            let dataDictionary = results[0]
                            if let videoKey = dataDictionary["key"] as? String {
                                if let youTubeUrl = URL(string: youTubeLink + videoKey) {
                                    completion(youTubeUrl)
                                    print(youTubeUrl)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    

    
    func getSerieFromApiForQuery(query: String, completion: @escaping ([Serie]) -> Void){
        let searchUrl = "https://api.themoviedb.org/3/search/tv?api_key=db898f2be5d80aee6fee0407b549ec39&language=en-US&query=\(query)&page=1"
        Alamofire.request(searchUrl).responseJSON{(response) in
            if let mainDictionary = response.result.value as? [String:AnyObject]{
                if let results = mainDictionary["results"] as? [[String: AnyObject]]{
                    var resultadosArray: [Serie] = []
                    for aDictionary in results{
                        let newResultado = Serie(dictionary: aDictionary)
                        resultadosArray.append(newResultado)
                    }
                    
                    completion(resultadosArray)
                }
                
            }
            
        }
    }

    
    
    func getGendersFromApi(completion: @escaping([Gender]) -> Void){
        let genderUrl = MovieHelper.getSeriesGender(lenguage: MovieHelper.language_ENGLISH)
        Alamofire.request(genderUrl).responseJSON{(response) in
            if let diccionarys = response.result.value as? [String:AnyObject]{
                if let gendersD = diccionarys["genres"] as? [[String:AnyObject]]{
                    var genders:[Gender] = []
                    for aDictionary in gendersD {
                        let newGender = Gender(dictionary: aDictionary)
                        genders.append(newGender)
                        
                    }
                    
                    completion(genders)
                    
                    
                } else{
                    
                    completion([])
                }
            }
        }
    }
    
    func getSeriesToGenre(genre: Gender, completion: @escaping ([Serie]) -> Void){
        let seriesToGenderURL = MovieHelper.getTVByGenre(genre: String(genre.id), page: 1, language: MovieHelper.language_ENGLISH)
        Alamofire.request(seriesToGenderURL).responseJSON{(response) in
            if let mainDiccionary = response.result.value as? [String:AnyObject]{
                if let seriesList = mainDiccionary["results"] as? [[String:AnyObject]]{
                    var series:[Serie] = []
                    for aSerie in seriesList{
                        let newSerie = Serie(dictionary: aSerie)
                        series.append(newSerie)
                        
                    }
                    
                    completion(series)
                } else{
                    completion([])
                }
            }
        }
    }

}


