//
//  File.swift
//  Timer
//
//  Created by Vladimir on 30.06.17.
//  Copyright © 2017 Vladimir. All rights reserved.
//

import Foundation
import UIKit

protocol StartTimeListener
{
    func startTimer(id:String)
}

class ApplicationController:StartTimeListener
{
    
    let dataBase = Database()
    let servise:Servise
    private var navigationController: UINavigationController
    
    init(navigationController: UINavigationController)
    {
        self.navigationController = navigationController
        self.servise = Servise(dataBase:dataBase)
        self.startService()
        self.showTimerTableViewController()
        
    }
    
    func showJobsViewController()
    {
        let jobsViewController = JobsViewController()
        navigationController.setViewControllers([jobsViewController], animated: false)
    }
    
    func showTimerTableViewController()
    {
        
        let timerTableViewController = TimeTableViewController(items:servise.dictionaryOfItems, startTimeListener:self)
        navigationController.setViewControllers([timerTableViewController], animated: false)
        
    }
    
    func startService() {
        
        
    }
    
    func startTimer(id:String){
        print(id)
        servise.setStartTime(id:id)
        servise.startTimer(id:id)
    }
}
