//
//  Serie.swift
//  Proyecto Integrador
//
//  Created by Serena Dominguez on 4/6/18.
//  Copyright © 2018 Digital House. All rights reserved.
//

import Foundation
import Kingfisher

class Serie {
    
    var title: String
    var releaseDate: String?
    var overview: String
    var isFavorite: Bool = false
    var urlStringB:String
    var urlImageBackdrop:URL?
    var voteAvarage: Double
    var popularity: Double
    var urlTrailer: URL?
    var id: NSNumber?
    var urlStringP:String
    var urlImagePoster:URL?
    
    
    
    
    init (dictionary: [String: AnyObject]) {
        self.title = dictionary["original_name"] as? String ?? "no name found"
        self.releaseDate = dictionary["first_air_date"] as? String ?? "no found"
        self.overview = dictionary["overview"] as? String ?? "no overview"
        self.urlStringB = dictionary["backdrop_path"] as? String ?? "no-url"
        self.popularity = dictionary["popularity"] as? Double ?? -1
        self.voteAvarage = dictionary["vote_average"] as? Double ?? -1
        self.id = dictionary["id"] as? NSNumber
        if urlStringB != "no-url"{
            urlImageBackdrop = URL(string:"https://image.tmdb.org/t/p/w500/" + urlStringB)
        }
        
        self.urlStringP = dictionary["poster_path"] as? String ?? "no-url"
        
        if urlStringP != "no-url" {
            urlImagePoster = URL(string:"https://image.tmdb.org/t/p/w500/" + urlStringP)
        }
        
        
    }
}
