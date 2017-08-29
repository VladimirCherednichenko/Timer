//
//  addTimerView.swift
//  Timer
//
//  Created by Vladimir Cherednichenko on 08.08.17.
//  Copyright © 2017 Vladimir. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class AddTimerViewLayout
{
    let titelLabel:UILabel = {
        let label = UILabel()
        label.text = "Please input:"
        label.textColor = UIColor.white
        label.font = Fonts.scriptFont
        return label
    }()
    
    let workNameTextField:UITextField = {
        let textField = UITextField()
        //textField.backgroundColor? = UIColor.white
        //textField.layer.cornerRadius = 15.0
        textField.text = " Name of work"
        textField.textAlignment = .center
        textField.backgroundColor = UIColor.clear
        textField.textColor = UIColor.white
        return textField
    }()
    
    

    
    let nextButton:UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        return button
    }()
    
    let cancelButton:UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        return button
    }()
    
    let datePicker:UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.tintColor = UIColor.red
        //datePicker.backgroundColor = UIColor.white
        //datePicker.alpha = 0.1
        datePicker.datePickerMode = .countDownTimer
        datePicker.setValue(UIColor.white, forKey: "textColor")
        return datePicker
    }()
    
    
    
    init(view:UIView) {
        //view.backgroundColor = UIColor.red
        view.addSubview(titelLabel)
        titelLabel.snp.makeConstraints{(make) -> Void in
            make.top.equalTo(view.snp.top)
            make.centerX.equalTo(view.snp.centerX)
            make.height.equalTo(60)
        }
       
        view.addSubview(workNameTextField)
        workNameTextField.snp.makeConstraints{(make) -> Void in
            make.top.equalTo(titelLabel.snp.bottom)
            make.right.equalTo(view.snp.right).offset(-5)
            make.left.equalTo(view.snp.left).offset(5)
        }
        
        
        
        
        view.addSubview(nextButton)
        
        nextButton.snp.makeConstraints{ (make) -> Void in
            make.bottom.equalTo(view.snp.bottom)
            make.right.equalTo(view.snp.right)
        }
        view.addSubview(cancelButton)
        
        cancelButton.snp.makeConstraints{ (make) -> Void in
            
            make.left.equalTo(view.snp.left)
            make.bottom.equalTo(view.snp.bottom)
        }
        
        view.addSubview(datePicker)
        
        datePicker.snp.makeConstraints{(make) -> Void in
            make.top.equalTo(workNameTextField.snp.bottom)
            make.centerX.equalTo(view.snp.centerX)
            make.right.equalTo(view.snp.right).offset(-5)
            make.left.equalTo(view.snp.left).offset(5)
        }

        
    }
}


