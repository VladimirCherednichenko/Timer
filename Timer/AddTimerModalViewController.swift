//
//  addTimerModalViewController.swift
//  Timer
//
//  Created by Vladimir Cherednichenko on 08.08.17.
//  Copyright © 2017 Vladimir. All rights reserved.
//

import Foundation
import UIKit

class AddTimerModalViewController:UIViewController {
    let subView = addTimerView()
    var newWorkSetterDelegate:NewWorkSetterDelegate
    
    init(newWorkSetterDelegate:NewWorkSetterDelegate)
    {
       self.newWorkSetterDelegate = newWorkSetterDelegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.black
        view.isOpaque = false
        //subView.clipsToBounds = true
        view.addSubview(subView)
        subView.snp.makeConstraints{ (make) -> Void in
            make.bottom.equalTo(view.snp.bottom)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.top.equalTo(view.snp.top)
        }
        
        subView.layout.cancelButton.addTarget(self, action: #selector(cancelButtonTuped), for: .touchUpInside)
        subView.layout.nextButton.addTarget(self, action: #selector(nextButtonTuped), for: .touchUpInside)
    }
    
    
    func cancelButtonTuped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func nextButtonTuped() {
        if subView.layout.workNameTextField.text != "" {
        let time:Double = subView.layout.datePicker.countDownDuration
            if let nameOfWork:String = subView.layout.workNameTextField.text {
                newWorkSetterDelegate.setNewWork(nameOfWork: nameOfWork, time: time) }
        self.dismiss(animated: true, completion: nil)
        } 
        
    }
    
}

class addTimerView:UIView,UITextFieldDelegate {
    
    var layout:AddTimerViewLayout!
    var timer = Timer()
    var workName:String?
    var amountTime:Double?
    
    required init()
    {
        let frame:CGRect = CGRect.init(x: 0, y: 0, width: 0, height: 0)
        super.init(frame: frame)
        self.layout = AddTimerViewLayout(view: self)
        self.backgroundColor = UIColor.black
        self.layout.workNameTextField.delegate = self
        //self.layout.amountTimeTextField.delegate = self
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
        textField.textColor = UIColor.white
    }
    
    func textFieldShouldReturn(_ textField: UITextField)
        -> Bool
    {
        
        if textField == layout.workNameTextField, textField.text != "" {
            self.workName = textField.text
            self.dismissKeyboard()
        }
        
        return false
    }
    
    func dismissKeyboard() {
        self.endEditing(true)
    }
    
    
}



