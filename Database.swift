//
//  Database.swift
//  Timer
//
//  Created by Vladimir on 30.06.17.
//  Copyright © 2017 Vladimir. All rights reserved.
//

import Foundation
import UIKit



class Database {
    let store = UserDefaults.standard
    
    private let key:String = "newkey"
    var items:[String:Item]?
    
    init()
    {
        
       readItems()
    }
    
    func saveItems(items:[String:Item])
    {
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: items)
        store.set(encodedData, forKey: key)
        print("i finished")
    }
    
    
    
    func readItems()
        
    {
        if let data = store.object(forKey: key) {
            self.items = (NSKeyedUnarchiver.unarchiveObject(with: data as! Data) as! [String:Item])
            
        }else{
            print("There is an issue")
        }
        
    }
}
