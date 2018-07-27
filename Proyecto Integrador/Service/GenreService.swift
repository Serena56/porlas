//
//  GenreService.swift
//  Proyecto Integrador
//
//  Created by Digital House on 25/7/18.
//  Copyright © 2018 Digital House. All rights reserved.
//

import Foundation


class GenreService{
    
    func getImageToGenreFromStorage(genre: Gender, completion: @escaping (URL) -> Void){
        let dao = GenreDao()
        dao.getImageToGenreFromStorage(genre: genre) { (url) in
            completion(url)
        }
    }
}
