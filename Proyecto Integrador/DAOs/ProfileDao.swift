//
//  ProfileDao.swift
//  Proyecto Integrador
//
//  Created by Digital House on 26/7/18.
//  Copyright © 2018 Digital House. All rights reserved.
//

import Foundation
import FirebaseUI
import Kingfisher


class ProfileDao{
    
    func getProfileDataFromDataBase(user: User, completion: @escaping ([String:AnyObject]) -> Void){
        
        var dictionary: [String:AnyObject] = [:]
        if let userName = user.displayName{
            dictionary["name"] = userName as AnyObject
        }
        
        if let userPicture = user.photoURL{
            let url = userPicture.absoluteString
            dictionary["url"] = url as AnyObject
        }
        
        completion(dictionary)
        
        
    }
    
    
    // No llegue a implementar esta función:
    
    func getImageFromDBToArchivement(arch: Archievement, completion: @escaping (URL) -> Void){
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let image = storageRef.child("\(arch.name)ArchImage.jpg")
        
        
        image.downloadURL(completion: { (url, error) in
            if let url = url {
                completion(url)
            } else{
                completion(URL(string:"https://firebasestorage.googleapis.com/v0/b/bloopdh-d5baa.appspot.com/o/ActionGNImage.jpg?alt=media&token=d2dbeff5-034b-42a8-960e-09f50d0dfcdd")!)
            }
        })
        
        
    }
}
    

