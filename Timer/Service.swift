//
//  File.swift
//  Timer
//
//  Created by Vladimir Cherednichenko on 16.08.17.
//  Copyright © 2017 Vladimir Cherednichenko. All rights reserved.
//

import Foundation

class Service:StopStartListener
{
    var dataBase:DataBase
    var dictionaryOfItems:[String:Item]
    var changesListener:ChangesListener
    var timer = Timer()
    init(dataBase:DataBase, changesListener:ChangesListener)
    {
        self.dataBase = dataBase
        self.dictionaryOfItems = dataBase.readItems()
        self.changesListener = changesListener
    }
    
    func setNewElement(amountTime:Double, name:String)
    {
        
        let identifier:String = String(getTimeIntervalSince1970())
        let item = Item(id:identifier,
                        name:name,
                        amountTime:amountTime,
                        timeStart:0,
                        remeinTime:amountTime,
                        completed:false)
        
        if dictionaryOfItems != [:] {
            self.dictionaryOfItems[identifier] = item
        } else {
            self.dictionaryOfItems = [identifier:item]
        }
        
        self.makeSomeChanges(itemsAdded: [item], itemsUpdated: nil, itemsDeleted: nil)
        self.saveDictionary()
        
    }
    
    func removeItemWithId(id:String)
    {
        dictionaryOfItems.removeValue(forKey: id)
        self.saveDictionary()
    }
    
    func saveDictionary()
    {
        dataBase.saveItems(items: self.dictionaryOfItems)
    }
    
    @objc func updateTimer()
    {
        let startedTimers = self.dictionaryOfItems.filter { $0.value.timeStart != nil }
        if startedTimers.count > 0 {
            for startedTimer in startedTimers {
             var curentRemeinTime = startedTimer.value.remeinTime
                if let timeStart:Double = startedTimer.value.timeStart {
                    curentRemeinTime = curentRemeinTime - (getTimeIntervalSince1970() - timeStart)
                }
                if curentRemeinTime < 0 {
                    startedTimer.value.remeinTime = 0
                    startedTimer.value.completed = true
                } else {
                    startedTimer.value.remeinTime = curentRemeinTime
                }
                dictionaryOfItems.updateValue(startedTimer.value, forKey: startedTimer.key)
                self.saveDictionaryOfItems()
            }
        }
    }
    
    func stopTimer(id:String)
    {
        self.updateTimer()
        if let item:Item = dictionaryOfItems[id] {
            item.timeStart = nil
        dictionaryOfItems.updateValue(item, forKey: id)
        }
        self.saveDictionary()
    }
    
    func startTimer(id:String)
    {
        var updatedItems:[Item] = []
        let startedTimers:Array = self.dictionaryOfItems.filter({ $0.value.timeStart != nil })
        for ItemWithID in startedTimers {
            stopTimer(id: ItemWithID.key)
            updatedItems.append(ItemWithID.value)
        }
        
        self.setStartTime(id:id)
        self.updateTimer()
        timer.invalidate()
        
        if let item:Item = dictionaryOfItems[id] {
            
            if item.timeStart != nil, !(item.completed) {
                
                let interval:Double = getTimeIntervalSince1970() - item.timeStart!
                
                if item.remeinTime > interval, !(item.completed) {
                    timer = Timer.scheduledTimer(timeInterval: item.remeinTime, target: self, selector: (#selector(updateTimer)), userInfo: nil, repeats: false)
                } else {
                    item.amountTime = 0
                    item.timeStart  = nil
                    item.completed = true
                }
                self.saveDictionary()
                
            }
            updatedItems.append(item)
            self.makeSomeChanges(itemsAdded: nil, itemsUpdated: updatedItems, itemsDeleted: nil)
        }
    }
    
    func stopAllTimers()
    {
        let startedTimers:Array = self.dictionaryOfItems.filter({ $0.value.timeStart != nil })
            for ItemWithID in startedTimers {
                stopTimer(id: ItemWithID.key)
            }
        
    }
    
    func setStartTime(id:String)
    {
        if let currentItem:Item = dictionaryOfItems[id] {
            if currentItem.timeStart == nil {
                currentItem.timeStart = getTimeIntervalSince1970()
                dictionaryOfItems.updateValue(currentItem, forKey: id)
                self.saveDictionary()
            }
        }
    }
    
    func saveDictionaryOfItems()
    {
        dataBase.saveItems(items: dictionaryOfItems)
    }
    
    func makeSomeChanges(itemsAdded: [Item]?, itemsUpdated: [Item]?, itemsDeleted: [Item]?)
    {
        self.changesListener.makeSomeChanges(itemsAdded:itemsAdded, itemsUpdated:itemsUpdated, itemsDeleted:itemsDeleted)
    }
}

func getTimeIntervalSince1970()
    -> Double
{   //returns time in seconds since 1970
    let now = NSDate()
    let currentTime:Double
    currentTime = now.timeIntervalSince1970
    return currentTime
}

func getTimeInStringFormat(seconds:Double)
    -> String
{
    
    
    //returns seconds in string format and its looks like normal timer. Example:12:30, 00:50
    var minutes:Int
    let moduloSeconds:Int
    let minutesString:String
    moduloSeconds = Int(seconds.truncatingRemainder(dividingBy: 60))
    minutes = (Int(seconds) - moduloSeconds) / 60
    
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

func getActualeRemeinTime(remeinTime:Double, timeStart:Double)
    -> Double
{   //returns remein time in seconds, its based on time when timer started and previous remein time, on start it might be amount time
    let actualeRemeinTime:Double
    actualeRemeinTime = remeinTime - (getTimeIntervalSince1970() - timeStart)
    return actualeRemeinTime
}
