//
//  PlistManager.swift
//  Proyecto Integrador
//
//  Created by Serena Dominguez on 4/6/18.
//  Copyright © 2018 Digital House. All rights reserved.
//

import Foundation

class PlistManager {
    

    static func readDictionary(name: String) -> [String: AnyObject] {
        var result: [String: AnyObject] = [:]
        
        if let plistPath = Bundle.main.path(forResource: name, ofType: "plist") {
            if let plistData = FileManager.default.contents(atPath: plistPath) {
                
                var propertyListFormat =  PropertyListSerialization.PropertyListFormat.xml
                do {
                    result = try PropertyListSerialization.propertyList(from: plistData,
                                                                        options: .mutableContainersAndLeaves,
                                                                        format: &propertyListFormat) as! [String: AnyObject]
                } catch {
                    print("Error reading plist: \(error)")
                }
                
            } else {
                print("Error reading plist: could not read file")
            }
            
        } else {
            print("Error reading plist: file not found")
        }
        
        return result
    }
    
}

