//
//  ProfileService.swift
//  Proyecto Integrador
//
//  Created by Digital House on 26/7/18.
//  Copyright © 2018 Digital House. All rights reserved.
//

import Foundation
import FirebaseUI

class ProfileService{
    
    var profile:ProfileViewController?
    var favorites:FavoritesTableViewController?
    
    
    
    func getProfileInfoFromDataBase(user: User, completion: @escaping ([String:AnyObject]) -> Void){
        
        let dao = ProfileDao()
        dao.getProfileDataFromDataBase(user: user) { (profileData) in
            completion(profileData)
        }
        
    
    }

}
