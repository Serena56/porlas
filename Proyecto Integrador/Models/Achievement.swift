//
//  Achievement.swift
//  Proyecto Integrador
//
//  Created by Digital House on 26/7/18.
//  Copyright © 2018 Digital House. All rights reserved.
//

import Foundation


class Archievement{
    var name:String
    var description:String
    var image:URL
    
    
    init (name: String, description: String, image: URL){
        self.name = name
        self.description = description
        self.image = image
    }
    
    init (dictionary: [String:AnyObject]){
        self.name = dictionary["name"] as? String ?? "no-name"
        self.description = dictionary["description"] as? String ?? "no-description"
        if let image = dictionary["image"] as? String{
            self.image =  URL(string: image)!
        } else{
            self.image = URL(string: "http://www.defante.com.ar/wp-content/themes/outlet/images/placeholder.jpg")!
        }
}
}
