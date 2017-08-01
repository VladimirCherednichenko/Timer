//
//  TabelViewDataSourse.swift
//  Timer
//
//  Created by Vladimir Cherednichenko on 31.07.17.
//  Copyright © 2017 Vladimir. All rights reserved.
//

import Foundation
import UIKit

class TimerTableViewDataSource:NSObject, UITableViewDataSource {
    
    var items:[String:Item]? = nil
    var startTimeListener:StartTimeListener?
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return items?.count ?? 0
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier = "identifier"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        
        if cell == nil, let startTimeListenerNotNil:StartTimeListener = startTimeListener {
            cell = CustomCell(reuseIdentifier: identifier, startTimeListener:startTimeListenerNotNil)
            cell?.selectionStyle = .default
            cell?.backgroundColor = UIColor.darkGray
            cell?.accessoryType = .disclosureIndicator
        }
        if items != nil {
            let arrayOfItems:Array? = Array(self.items!.values)
            let arrayOfKeys:Array? = Array(self.items!.keys)
            
            if let currentItem = arrayOfItems?[indexPath.row], let keyOfCurrentItem = arrayOfKeys?[indexPath.row] {
                
                if let customCell = cell as? CustomCell {
                    //customCell.setLabeltext(name: currentItem.name, score: "\(currentItem.score)")
                    customCell.setNewTimer(item:currentItem, key:keyOfCurrentItem)
                    /*DispatchQueue.global().async {
                     let image = currentItem.readUIImage()
                     DispatchQueue.main.async {
                     customCell.setImage(image: image)
                     }
                     }*/
                }
            }
        }
        return cell == nil ? UITableViewCell() : cell!
    }
    
    
    
}

class CustomCell:UITableViewCell{
    
    var timerView:TimerControllView?
    var currentItem:Item?
    var keyOfItem:String?
    var startTimeListener:StartTimeListener
    init(reuseIdentifier: String, startTimeListener:StartTimeListener)
    {
        self.startTimeListener = startTimeListener
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.black
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setNewTimer(item:Item,key:String)
    {
        let timerView = TimerControllView()
        
        self.contentView.addSubview(timerView)
        self.currentItem = item
        self.keyOfItem = key
        
        timerView.snp.makeConstraints{(make) -> Void in
            make.top.equalTo(self.snp.top)
            make.bottom.equalTo(self.snp.bottom)
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
        }
        
        timerView.setNewWorkWith(name: item.name, amountTime: getTimeInStringFormat(seconds: item.amountTime), remeinTime: getTimeInStringFormat(seconds: item.remeinTime))
        timerView.layout.startButton.addTarget(self, action: #selector(startTimer), for: .touchUpInside)
    }
    
    @objc func startTimer()
    {
        if let id:String = self.keyOfItem {
        startTimeListener.startTimer(id: id)
        }
        
    }
    
    
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
