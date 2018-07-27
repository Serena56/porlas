//
//  MovieDao.swift
//  Proyecto Integrador
//
//  Created by Digital House on 4/7/18.
//  Copyright © 2018 Digital House. All rights reserved.
//

import Foundation
import Alamofire
import FirebaseStorage

class MovieDao{
    
    func getMoviesFromApi(page: Int, completion: @escaping([Pelicula]) -> Void){
        let popularUrl = MovieHelper.getPopularMovies(language: MovieHelper.language_ENGLISH, page: page)
        print(popularUrl)
        Alamofire.request(popularUrl).responseJSON{(response) in
            if let mainDictionary = response.result.value as? [String:AnyObject]{
                if let results = mainDictionary["results"] as? [[String:AnyObject]]{
                    var moviesArray:[Pelicula] = []
                    for aDictionary in results{
                        let newMovie = Pelicula(dictionary: aDictionary)
                        moviesArray.append(newMovie)
                    }
                    
                    completion(moviesArray)
                } else{
                    completion([])
                }
                
            }
        }
    }
    
    func getMoviesRecomendations(page: Int, movie: Pelicula, completion: @escaping([Pelicula]) -> Void){
        if let movieId = movie.id {
            let popularUrl = "https://api.themoviedb.org/3/movie/\(movieId)/similar?api_key=db898f2be5d80aee6fee0407b549ec39&language=en-US&page=1"
            print(popularUrl)
            Alamofire.request(popularUrl).responseJSON{(response) in
                if let mainDictionary = response.result.value as? [String:AnyObject]{
                    if let results = mainDictionary["results"] as? [[String:AnyObject]]{
                        var moviesArray:[Pelicula] = []
                        for aDictionary in results{
                            let newMovie = Pelicula(dictionary: aDictionary)
                            moviesArray.append(newMovie)
                        }
                        
                        completion(moviesArray)
                    } else{
                        completion([])
                    }
                    
                }
            }
        }
    }
    
    func getMoviesFromApiForQuery(query:String, completion: @escaping ([Pelicula]) -> Void){
        let searchUrl = "https://api.themoviedb.org/3/search/movie?api_key=db898f2be5d80aee6fee0407b549ec39&language=en-US&query=\(query)&page=1"
        Alamofire.request(searchUrl).responseJSON{(response) in
        if let mainDictionary = response.result.value as? [String:AnyObject]{
            if let results = mainDictionary["results"] as? [[String:AnyObject]]{
                var resultadosArray:[Pelicula] = []
                for aDictionary in results{
                    let newResultado = Pelicula(dictionary: aDictionary)
                    resultadosArray.append(newResultado)
                    }
                
                completion(resultadosArray)
                }
            
            }
        
        }
    }
    
    
    func getGendersFromApi(completion: @escaping([Gender]) -> Void){
        let genderUrl = MovieHelper.getMoviesGender(lenguage: MovieHelper.language_ENGLISH)
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
    
    func getMoviesToGender(genre: Gender, completion: @escaping ([Pelicula]) -> Void){
        let moviesToGenderURL = MovieHelper.getMoviesByGenre(genre: String(genre.id), page: 1, language: MovieHelper.language_ENGLISH)
        Alamofire.request(moviesToGenderURL).responseJSON{(response) in
            if let mainDiccionary = response.result.value as? [String:AnyObject]{
                if let moviesList = mainDiccionary["results"] as? [[String:AnyObject]] {
                    var movies:[Pelicula] = []
                    for aMovie in moviesList{
                        let newMovie = Pelicula(dictionary: aMovie)
                        movies.append(newMovie)
                        
                    }
                    
                    completion(movies)
                } else{
                    completion([])
                }
            }
        }
    
    }
    
    func getYoutubeUrl (movie: Pelicula, completion: @escaping (URL) -> Void) {
        if let movieId = movie.id {
            print(movieId)
            let youTubeLink = "https://www.youtube.com/watch?v="
            let videoData = "https://api.themoviedb.org/3/movie/\(movieId)/videos?api_key=db898f2be5d80aee6fee0407b549ec39&language=en-US&page=1"
            
            Alamofire.request(videoData).responseJSON { (response) in
                if let dictionary = response.result.value as? [String: AnyObject] {
                    if let results = dictionary["results"] as? [[String: AnyObject]] {
                        if results.isEmpty == false {
                            let dataDictionary = results[0]
                            if let videoKey = dataDictionary["key"] as? String {
                                if let youTubeUrl = URL(string: youTubeLink + videoKey) {
                                    completion(youTubeUrl)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    

}
