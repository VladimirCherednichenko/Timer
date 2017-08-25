
//
//  TabelViewDataSourse.swift
//  Timer
//
//  Created by Vladimir Cherednichenko on 31.07.17.
//  Copyright © 2017 Vladimir. All rights reserved.
//

import Foundation
import UIKit

class CustomCell:UITableViewCell{
    var timer = Timer()
    var timerView = TimerControllView()
    var currentItem:Item?
    var listener:CellListener
    var updateDelegat:UpdateDelegate
    let updateInterval:TimeInterval = 0.5
    
    init(reuseIdentifier: String, listener:CellListener, updateDelegat: UpdateDelegate)
    {
        print(reuseIdentifier)
        
        self.updateDelegat = updateDelegat
        self.listener = listener
        
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.black
        self.contentView.addSubview(timerView)
        timerView.snp.makeConstraints{(make) -> Void in
            make.top.equalTo(self.snp.top)
            make.bottom.equalTo(self.snp.bottom)
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
        }
        if currentItem != nil {
        self.setNewTimer(item: currentItem!)
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    func setNewTimer(item:Item)
    {
        
        
        self.currentItem = item
        if item.timeStart != nil {
           self.resumeTimer()
        } else {
            
        self.updateTimer()
        timerView.setNewWorkWith(name: item.name, amountTime: getTimeInStringFormat(seconds: item.amountTime), remeinTime: getTimeInStringFormat(seconds: item.remeinTime))
        self.prepareForStart()
        }
    }
    
    @objc func startTimer()
    {
        self.timer.invalidate()
        self.timer = Timer.scheduledTimer(timeInterval: updateInterval, target: self, selector: (#selector(self.updateTimer)), userInfo: nil, repeats: true)
        
        if let id:String = currentItem?.id {
            listener.startTimer(id: id)
        }
        self.prepearForStop()
    }
    
    func resumeTimer()
    {
        self.timer.invalidate()
        self.timer = Timer.scheduledTimer(timeInterval: updateInterval, target: self, selector: (#selector(self.updateTimer)), userInfo: nil, repeats: true)
        self.prepearForStop()
    }
    
    func updateTimer()
    {
        if let remeinTime:Double = currentItem?.remeinTime, let timeStart:Double = currentItem?.timeStart {
            let remeinTime = getActualeRemeinTime(remeinTime: remeinTime, timeStart: timeStart)
            if remeinTime < 0 {
                self.timer.invalidate()
            } else {
                self.timerView.updateTime(remeinTime: getTimeInStringFormat(seconds: remeinTime))
            }
        }
    }
    
    
    
    func prepearForStop(){
        timerView.makeStopButton()
        timerView.layout.startButton.removeTarget(self, action: #selector(startTimer), for: .touchUpInside)
        timerView.layout.startButton.addTarget(self, action: #selector(stopTimer), for: .touchUpInside)
    }
    
    @objc func stopTimer()
    {
        self.timer.invalidate()
        if let id:String = currentItem?.id {
        listener.stopTimer(id: id)
        self.updateDelegat.updateTimerWithID(id: id)
        }
        
        self.prepareForStart()
    }
    
    @objc func prepareForStart()
    {
        timerView.makeStartButton()
        timerView.layout.startButton.removeTarget(self, action: #selector(stopTimer), for: .touchUpInside)
        timerView.layout.startButton.addTarget(self, action: #selector(startTimer), for: .touchUpInside)
        timerView.layout.startButton.target
    }
    
    override func prepareForReuse() {
        
        self.timer.invalidate()
        if let item:Item = currentItem {
        self.updateDelegat.updateTimerWithID(id: item.id)
        }
    }
    
}

func getTimeInStringFormat(seconds:Double)
    -> String
{   //returns seconds in string format and its looks like normal timer. Example:12:30, 00:50
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


