//
//  DataBase.swift
//  Timer
//
//  Created by Vladimir Cherednichenko on 16.08.17.
//  Copyright © 2017 Vladimir Cherednichenko. All rights reserved.
//

import Foundation

class DataBase {
    let store = UserDefaults.standard
    
    private let key:String = "Key1"
    
    
    func saveItems(items:[String:Item])
    {
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: items)
        store.set(encodedData, forKey: key)
        print("data base saved")
    }
    
    func readItems()
        -> [String:Item]
    {
        let items:[String:Item]
        if let data = store.object(forKey: key) {
            items = (NSKeyedUnarchiver.unarchiveObject(with: data as! Data) as! [String:Item])
            
        }else{
            items = [:]
            print("no saved item")
        }
        
        return items
    }
}
