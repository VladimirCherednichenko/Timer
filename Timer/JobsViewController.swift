//
//  ViewController.swift
//  Timer
//
//  Created by Vladimir on 30.06.17.
//  Copyright © 2017 Vladimir. All rights reserved.
//

import UIKit
import SnapKit

class JobsViewController: UIViewController {
    
    
    
    
    
    
    override func viewDidLoad() {
        self.navigationController?.isNavigationBarHidden = true
        super.viewDidLoad()
        let timerView = TimerControllView()
        self.view.addSubview(timerView)
        
    }
    
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
}





class TimerControllView:UIView
{
    var timer = Timer()
    var pauseTup:Bool = false
    let startSeconds:Double = 60
    var seconds:Double
    let updateInterval:Double = 1
    //BRING IT TO LAYOUT
    let titelLabel:UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.text = "Morning Excercise"
        return label
    } ()
    let timeLabel:UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.textColor = UIColor.white
        label.font = Fonts.bigTimeFont
        return label
    }()
    let startTimeLabel:UILabel = {
        let label = UILabel()
        label.text = "| 30:00"
        label.textColor = UIColor.white
        label.font = Fonts.smallTimeFont
        return label
    }()
    let startButton:UIButton = {
        let button = UIButton()
        button.setTitle("Start", for: .normal)
        return button
    }()
    
    
    func updateTimer()
    {
        if seconds > 0 {
            seconds = seconds - updateInterval
            timeLabel.text = "\(seconds)"
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
    
    required init()
    {
        seconds = startSeconds
        
        super.init(frame: UIScreen.main.bounds)
        self.backgroundColor = UIColor.darkGray
        
        
        self.addSubview(titelLabel)
        titelLabel.snp.makeConstraints{(make) -> Void in
            make.top.equalTo(self.snp.top)
            make.left.equalTo(self.snp.left)
        }
        
        
        self.addSubview(timeLabel)
        timeLabel.snp.makeConstraints{(make) -> Void in
            make.left.equalTo(titelLabel.snp.left)
            make.top.equalTo(titelLabel.snp.bottom)
        }
        
        
        
        self.addSubview(startTimeLabel)
        startTimeLabel.snp.makeConstraints{(make) -> Void in
            make.left.equalTo(timeLabel.snp.right)
            make.top.equalTo(timeLabel.snp.top)
        }
        
        
        self.addSubview(startButton)
        
        startButton.snp.makeConstraints{(make) -> Void in
            make.top.equalTo(timeLabel.snp.bottom)
            make.left.equalTo(timeLabel.snp.right)
        }
        
        startButton.addTarget(self, action: (#selector(startButtonTuped)), for: .touchUpInside)
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

