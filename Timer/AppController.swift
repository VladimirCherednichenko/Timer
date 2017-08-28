//
//  AppControler.swift
//  Timer
//
//  Created by Vladimir Cherednichenko on 16.08.17.
//  Copyright © 2017 Vladimir Cherednichenko. All rights reserved.
//

import Foundation
import UIKit

protocol ChangesListener
{
    func makeSomeChanges(itemsAdded: [Item]?, itemsUpdated: [Item]?, itemsDeleted: [Item]?)
}



protocol AddItemDelegate
{
    func addNewItem(name:String, time:Double)
}

class ApplicationController:ChangesListener, AddItemDelegate, StopStartListener
{
    var navigationController:UINavigationController
    var service:Service?
    var changesListener:ChangesListener?
    
    init(navigationController:UINavigationController)
    {
        self.navigationController = navigationController
        let dataBase = DataBase()
        self.startService()
        self.showTableWithTimers()
    }
    
    func startService()
    {
        let dataBase = DataBase()
        self.service = Service(dataBase: dataBase, changesListener:self)
    }
    
    
    func showTableWithTimers ()
    {
        if let service:Service = self.service {
            let tabelView = TableView(items: service.dictionaryOfItems, addItemDelegate:self, stopStartListener:self)
            self.changesListener = tabelView
            navigationController.setViewControllers([tabelView], animated: false)
        }
        
        
    }
    
    func showCircle()
    {
        if let circleView:UIView = CircleView(){
            
            let viewController = EmptyViewController(view: circleView)
            navigationController.setViewControllers([viewController], animated: false)}
    }
    
    func addNewItem(name:String, time:Double)
    {
       if let service:Service = self.service {
        service.setNewElement(amountTime: time, name: name)
        }
    }
    
    func makeSomeChanges(itemsAdded: [Item]?, itemsUpdated: [Item]?, itemsDeleted: [Item]?)
    {
        if let changesListener:ChangesListener = self.changesListener {
            changesListener.makeSomeChanges(itemsAdded: itemsAdded, itemsUpdated: itemsUpdated, itemsDeleted: itemsDeleted)
        }
    }
    
    func startTimer(id:String) {
        if let service:StopStartListener = self.service {
            service.startTimer(id: id)
        }
    }
    
    func stopTimer(id:String) {
        if let service:StopStartListener = self.service {
            service.stopTimer(id: id)
        }
    }
    
    
    
    
}
