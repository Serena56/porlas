//
//  AchievementService.swift
//  Proyecto Integrador
//
//  Created by Digital House on 26/7/18.
//  Copyright © 2018 Digital House. All rights reserved.
//

import Foundation

class ArchievementService{
    var profile: ProfileViewController? //No lo usa, aun.
    
    //Esta funcion termino siendo un choclo gigante, no tiene escalabilidad y estan harcodeados los logros/imagenes. x
    
    func getLocalArchievement(completion: @escaping ([Archievement]) -> Void){
        
        
        
        
        
        
        let defaults = UserDefaults.standard
        var archievement:[Archievement] = []
        
        let loginArch = Archievement(name: "Welcome!", description: "You´ve joined Bloop, thanks!", image: URL(string:"https://cdn.pixabay.com/photo/2013/07/12/18/29/trophy-153395_960_720.png")!)
        archievement.append(loginArch)
        
        
        let detailSerieArch = defaults.bool(forKey: "DetailSerieArch")
        if detailSerieArch == true{
            let newArch = Archievement(name: "Series Retailer" , description: "You saw the detail of a series", image: URL(string: "https://vignette.wikia.nocookie.net/deathnote/images/7/76/Gold_medal.png/revision/latest?cb=20140114181807&path-prefix=es")!)
                archievement.append(newArch)
            
        }
        
        let detailMovieArch = defaults.bool(forKey:"MovieDetailArch")
        if detailMovieArch == true{
            let newArch = Archievement(name: "Movie Retailer", description: "You saw the detail of a movie", image: URL(string: "https://www.kkvmagazin.hu/wp-content/uploads/2015/06/gold-medal2.png")!)
            
            archievement.append(newArch)
        }
        
        
        
        
        completion(archievement)
        
    }
    
    
    
}


