//
//  TimerLayout.swift
//  Timer
//
//  Created by Vladimir Cherednichenko on 31.07.17.
//  Copyright © 2017 Vladimir. All rights reserved.
//

import Foundation
import UIKit

class TimerLayout {
    let nameOfWorkLabel:UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.text = "Morning Excercise"
        return label
    } ()
    let remeinTimeLabel:UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.textColor = UIColor.white
        label.font = Fonts.bigTimeFont
        return label
    }()
    let amountTimeLabel:UILabel = {
        let label = UILabel()
        label.text = "| 40:00"
        label.textColor = UIColor.white
        label.font = Fonts.smallTimeFont
        return label
    }()
    let startButton:UIButton = {
        let button = UIButton()
        button.setTitle("Start", for: .normal)
        return button
    }()
    
    init(view:UIView)
    {
        view.backgroundColor = UIColor.init(red: 29/255, green: 30/255, blue: 62/255, alpha: 1)
        view.addSubview(nameOfWorkLabel)
        nameOfWorkLabel.snp.makeConstraints{(make) -> Void in
            make.top.equalTo(view.snp.top)
            make.left.equalTo(view.snp.left)}
        view.addSubview(remeinTimeLabel)
        remeinTimeLabel.snp.makeConstraints{(make) -> Void in
            make.left.equalTo(nameOfWorkLabel.snp.left)
            make.top.equalTo(nameOfWorkLabel.snp.bottom)}
        view.addSubview(amountTimeLabel)
        amountTimeLabel.snp.makeConstraints{(make) -> Void in
            make.left.equalTo(remeinTimeLabel.snp.right)
            make.top.equalTo(remeinTimeLabel.snp.top)}
        view.addSubview(startButton)
        startButton.snp.makeConstraints{(make) -> Void in
            make.top.equalTo(remeinTimeLabel.snp.bottom)
            make.left.equalTo(remeinTimeLabel.snp.right)}
    }
    
}
