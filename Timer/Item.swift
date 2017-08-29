//
//  Item.swift
//  Timer
//
//  Created by Vladimir Cherednichenko on 16.08.17.
//  Copyright © 2017 Vladimir Cherednichenko. All rights reserved.
//

import Foundation
class Item: NSObject, NSCoding {
    var id:String
    var name:String
    var amountTime:Double
    var timeStart:Double?
    var remeinTime:Double
    var completed = false
    
    
    init(id:String, name:String, amountTime:Double, timeStart:Double?, remeinTime:Double,completed:Bool)
    {
        self.id = id
        self.name = name
        self.amountTime = amountTime
        self.remeinTime = remeinTime
        self.completed = completed
        
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let id = aDecoder.decodeObject(forKey: "id") as! String
        let name = aDecoder.decodeObject(forKey: "name") as! String
        let amountTime = aDecoder.decodeDouble(forKey: "amountTime")
        let timeStart = aDecoder.decodeObject(forKey: "timeStart") as? Double
        let remeinTime = aDecoder.decodeDouble(forKey: "remeinTime")
        let completed = aDecoder.decodeBool(forKey: "comleted")
        self.init(
            id:id,
            name:name,
            amountTime:amountTime,
            timeStart:timeStart,
            remeinTime:remeinTime,
            completed:completed
        )
        
    }
    
    func encode(with aCoder: NSCoder)
    {
        aCoder.encode(self.id, forKey: "id")
        aCoder.encode(self.name, forKey: "name")
        aCoder.encode(self.amountTime, forKey: "amountTime")
        aCoder.encode(self.timeStart, forKey: "timeStart")
        aCoder.encode(self.remeinTime, forKey: "remeinTime")
        aCoder.encode(self.completed, forKey: "completed")
    }
}
