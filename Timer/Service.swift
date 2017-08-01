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
    var dataBase:Database
    var currentItem:Item?
    var timer = Timer()
    var timer5Second = Timer()
    var dictionaryOfItems:[String:Item]?
    let store = UserDefaults.standard
    
    init(dataBase:Database)
    {
        self.dataBase = dataBase
        self.readItemsFromDataBase()
        print(dictionaryOfItems as Any)
    }
    
    func setNewElement(amountTime:Double, name:String)
    {
        
        let identifier:String = String(self.getTimeIntervalSince1970())
        print("this is id \(identifier)")
        let item = Item(name:name,
                        amountTime:amountTime,
                        timeStart:0,
                        remeinTime:amountTime,
                        completed:false)
        
        if dictionaryOfItems != nil {
            self.dictionaryOfItems?[identifier] = item
        } else {
            self.dictionaryOfItems = [identifier:item]
        }
        print ("ill save it for you with id \(identifier):\(name)")
        dataBase.saveItems(items: dictionaryOfItems!)
    }
    
    @objc func saveDictionaryOfItems()
    {
        if let dictionary:[String:Item] = self.dictionaryOfItems {
            dataBase.saveItems(items: dictionary)
        }
    }
    
    func setStartTime(id:String)
    {
        if let currentItem:Item = dictionaryOfItems![id] {
            if currentItem.timeStart != nil {
                currentItem.timeStart = self.getTimeIntervalSince1970()
                dictionaryOfItems?.updateValue(currentItem, forKey: id)
                print(dictionaryOfItems![id]?.timeStart as Any)
                self.saveDictionaryOfItems()
            }
        }
    }
    
    func getTimeIntervalSince1970()
        -> Double
    {   //возвращает количество секунд прошедшие с 1970
        let now = NSDate()
        let currentTime:Double
        currentTime = now.timeIntervalSince1970
        return currentTime
    }
    
    @objc func updateTime()
    {
        if currentItem != nil {
            
            currentItem!.remeinTime = 0
            currentItem!.completed = true
            print(currentItem!.remeinTime)
            self.saveDictionaryOfItems()
            
            
            
            dictionaryOfItems?.updateValue(self.currentItem!, forKey: (self.currentItem?.name)!)
        }
    }
    
    func startTimer(id:String)
    {
        timer.invalidate()
        if let item:Item = dictionaryOfItems?[id] {
            if item.timeStart != nil {
                self.currentItem = item
                let interval:Double = self.getTimeIntervalSince1970() - currentItem!.timeStart!
                if currentItem!.remeinTime > interval {
                    timer = Timer.scheduledTimer(timeInterval: item.remeinTime, target: self, selector: (#selector(updateTime)), userInfo: nil, repeats: false)
                } else {
                    currentItem!.amountTime = 0
                    currentItem!.timeStart  = nil
                    currentItem!.completed = true
                    self.stopSaving()
                }
                self.saveDictionaryOfItems()
                
            }
        }
    }
    
    func readItemsFromDataBase()
    {
        self.dictionaryOfItems = dataBase.items
    }
    
    func startTimerForDictionarySaving()
    {
        timer5Second.invalidate()
        timer5Second = Timer.scheduledTimer(timeInterval: 5, target: self, selector: (#selector(saveDictionaryOfItems)), userInfo: nil, repeats: true)
        
    }
    
    func stopSaving()
    {
        timer5Second.invalidate()
    }
    
    func getTimeInStringFormat(seconds:Double)
        -> String
    {
        var minutes:Int
        let moduloSeconds:Int
        let minutesString:String
        moduloSeconds = Int(seconds.truncatingRemainder(dividingBy: 60))
        minutes = Int((seconds / 60).rounded())
        
        if minutes<10 && moduloSeconds<10 {
            minutesString = ("0\(minutes):0\(moduloSeconds)")
        } else if minutes<10 {
            minutesString = ("0\(minutes):\(moduloSeconds)")
        } else if moduloSeconds<10 {
            minutesString = ("\(minutes):0\(moduloSeconds)")
        } else {
            minutesString = ("\(minutes):\(moduloSeconds)")
        }
        return minutesString
    }
    
    
    
    
    
}
