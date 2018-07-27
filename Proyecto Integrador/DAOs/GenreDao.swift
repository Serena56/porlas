//
//  GenreDao.swift
//  Proyecto Integrador
//
//  Created by Digital House on 25/7/18.
//  Copyright © 2018 Digital House. All rights reserved.
//

import Foundation
import Alamofire
import FirebaseStorage

class GenreDao{
    
    func getImageToGenreFromStorage(genre: Gender, completion: @escaping (URL) -> Void){
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let image = storageRef.child("\(genre.name)GNImage.jpg")
        
        
        image.downloadURL(completion: { (url, error) in
            if let url = url {
                completion(url)
            } else{
                completion(URL(string:"https://firebasestorage.googleapis.com/v0/b/bloopdh-d5baa.appspot.com/o/ActionGNImage.jpg?alt=media&token=d2dbeff5-034b-42a8-960e-09f50d0dfcdd")!)
            }
        })
    
    
}
}
