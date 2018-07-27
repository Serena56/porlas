//
//  Pelicula.swift
//  Proyecto Integrador
//
//  Created by Serena Dominguez on 4/6/18.
//  Copyright © 2018 Digital House. All rights reserved.
//

import Foundation

class Pelicula {
    
    var voteAvarage: Double?
    var title: String
    var popularity: Double?
    var originalLanguage: String
    var adult: Bool
    var overview: String
    var isFavorite: Bool = false
    
    var urlStringB:String
    var urlImageBackdrop:URL?
    
    var urlStringP:String
    var urlImagePoster:URL?
    var id: NSNumber?
    var releaseDate: String?
    
    
    init (dictionary: [String: AnyObject]) {
        self.voteAvarage = dictionary["vote_average"] as? Double
        self.title = dictionary["title"] as? String ?? "no title found"
        self.popularity = dictionary["popularity"] as? Double
        self.id = dictionary["id"] as? NSNumber
        self.originalLanguage = dictionary["original_language"] as? String ?? "no language info"
        self.adult = dictionary["adult"] as? Bool ?? false
        self.overview = dictionary["overview"] as? String ?? "no overview"
        self.releaseDate = dictionary["release_date"] as? String ?? "problem dude"
        self.urlStringB = dictionary["backdrop_path"] as? String ?? "no-url"
        if urlStringB != "no-url"{
            urlImageBackdrop = URL(string: "https://image.tmdb.org/t/p/w500/" + urlStringB)
        }
        
       self.urlStringP = dictionary["poster_path"] as? String ?? "no-url"
        if urlStringP != "no-url"{
            urlImagePoster = URL(string:"https://image.tmdb.org/t/p/w500/" + urlStringP)
        }
    }
}

