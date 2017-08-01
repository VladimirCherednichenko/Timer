//
//  Item.swift
//  Timer
//
//  Created by Vladimir on 07.07.17.
//  Copyright © 2017 Vladimir. All rights reserved.
//

import Foundation

class Item: NSObject, NSCoding
{
    var name:String
    var amountTime:Double
    var timeStart:Double?
    var remeinTime:Double
    var completed = false
    
    init(name:String, amountTime:Double, timeStart:Double?, remeinTime:Double,completed:Bool)
    {
        self.name = name
        self.amountTime = amountTime
        self.remeinTime = remeinTime
        self.completed = completed
        
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObject(forKey: "name") as! String
        print(name)
        let amountTime = aDecoder.decodeDouble(forKey: "amountTime")
        let timeStart = aDecoder.decodeObject(forKey: "timeStart") as? Double
        let remeinTime = aDecoder.decodeDouble(forKey: "remeinTime")
        let completed = aDecoder.decodeBool(forKey: "comleted")
         self.init(
            name:name,
            amountTime:amountTime,
            timeStart:timeStart,
            remeinTime:remeinTime,
            completed:completed
        )
        
    }
    
    func encode(with aCoder: NSCoder)
    {
        aCoder.encode(self.name, forKey: "name")
        aCoder.encode(self.amountTime, forKey: "amountTime")
        aCoder.encode(self.timeStart, forKey: "timeStart")
        aCoder.encode(self.remeinTime, forKey: "remeinTime")
        aCoder.encode(self.completed, forKey: "completed")
    }
}
