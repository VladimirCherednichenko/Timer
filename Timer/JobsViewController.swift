//
//  ViewController.swift
//  Timer
//
//  Created by Vladimir on 30.06.17.
//  Copyright © 2017 Vladimir. All rights reserved.
//

import UIKit
import SnapKit

class JobsViewController: UIViewController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        // let timerView = TimerControllView()
        //self.view.addSubview(timerView)
        
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
}





class TimerControllView:UIView
{
    
    var layout:TimerLayout!
    var timer = Timer()
    var pauseTup:Bool = false
    let startSeconds:Double = 60
    var seconds:Double
    let updateInterval:Double = 1
    
    
    
    required init()
    {
        seconds = startSeconds
        let frame:CGRect = CGRect.init(x: 0, y: 0, width: 0, height: 0)
        
        super.init(frame: frame)
        self.layout = TimerLayout(view: self)
        self.backgroundColor = UIColor.darkGray
        
        
        
        
        self.layout.startButton.addTarget(self, action: (#selector(startButtonTuped)), for: .touchUpInside)
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setNewWorkWith(name:String, amountTime:String, remeinTime:String)
    {
        layout.nameOfWorkLabel.text = name
        layout.amountTimeLabel.text = amountTime
        layout.remeinTimeLabel.text = remeinTime
    }
    
    func updateTime(remeinTime:String)
    {
       layout.remeinTimeLabel.text = remeinTime
    }
    
    func makeStopButton()
    {
        layout.startButton.setTitle("Stop", for: .normal)
    }
    
    func updateTimer()
    {
        if seconds > 0 {
            seconds = seconds - updateInterval
            self.layout.remeinTimeLabel.text = "\(seconds)"
        } else {
            timer.invalidate()
        }
    }
    
    func startTimer()
    {
        timer = Timer.scheduledTimer(timeInterval: updateInterval, target: self, selector: (#selector(self.updateTimer)), userInfo: nil, repeats: true)
        //startButton.allTargets = nil
        
    }
    
    func stopTimer()
    {
        timer.invalidate()
        pauseTup = false
    }
    
    func startButtonTuped()
    {
        if !pauseTup {
            startTimer()
            pauseTup = true
        } else {
            stopTimer()
            pauseTup = false
        }
        
    }
    
}

