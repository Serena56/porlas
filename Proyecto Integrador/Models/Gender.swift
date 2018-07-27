//
//  Gender.swift
//  Proyecto Integrador
//
//  Created by Digital House on 19/7/18.
//  Copyright © 2018 Digital House. All rights reserved.
//

import Foundation


class Gender{
    var name:String
    var id:Int
    
    init(dictionary: [String:AnyObject] ){
        self.name = dictionary["name"] as? String ?? "no lei el name del genero"
        self.id = dictionary["id"] as? Int ?? -00000000
    }
    
    init (name: String, id: Int){
        self.name = name
        self.id = id
    }
}
