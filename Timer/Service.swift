//
//  Service.swift
//  Timer
//
//  Created by Vladimir on 04.07.17.
//  Copyright © 2017 Vladimir. All rights reserved.
//

import Foundation

class Servise
{
    var currentItem:Item?
    var dictionaryOfItems:[String:Item]?
    let store = UserDefaults.standard
    func setNewElement(amountTime:Double, name:String)
    {
        let item = Item(amountTime: amountTime, name: name)
        if dictionaryOfItems != nil {
        dictionaryOfItems?[name] = item
        } else {
            dictionaryOfItems = [name:item]
        }
    }
    
    func setStartTime(timeStart:Double,name:String)
    {
       if var currentItem:Item = dictionaryOfItems?[name] {
         currentItem.timeStart = timeStart
        
        }
    }
    
    func getStartTime()
        -> Double
    {
        let now = NSDate()
        let currentTime:Double
        currentTime = now.timeIntervalSinceReferenceDate
        
        return currentTime
    }
    
    func updateTime(name:String)
    {
        let now = NSDate()
        print(now.timeIntervalSinceReferenceDate)
        
        if var currentItem:Item = dictionaryOfItems?[name] {
            if currentItem.timeStart != nil {
                let interval:Double = now.timeIntervalSinceReferenceDate - currentItem.timeStart!
                if currentItem.amountTime > interval {
                currentItem.amountTime = currentItem.amountTime - interval
                }
            }
        }
    }
    
    func saveItem()
    {
        
    }
    
    
    
}
