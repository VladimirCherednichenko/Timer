//
//  TabelView.swift
//  
//
//  Created by Vladimir Cherednichenko on 17.08.17.
//

import Foundation
import UIKit



protocol StopStartListener {
    func stopTimer(id:String)
    func startTimer(id:String)
}

class TableView:UITableViewController, ChangesListener, StopStartListener
{
    
    var items:[String:Item]
    var cellHeight:CGFloat = 100
    var addItemDelegate:AddItemDelegate
    var stopStartListener:StopStartListener
    init(items:[String:Item], addItemDelegate:AddItemDelegate, stopStartListener:StopStartListener)
    {
        self.stopStartListener = stopStartListener
        self.items = items
        self.addItemDelegate = addItemDelegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.barTintColor = UIColor.init(red: 29/255, green: 30/255, blue: 62/255, alpha: 1)
    }
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableView.reloadData()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addTupped))
    }
    
    @objc func addTupped()
    {
        let addTimerModalViewController = AddTimerModalViewController(addItemDelegate:self.addItemDelegate)
        addTimerModalViewController.modalPresentationStyle = .overCurrentContext
        present(addTimerModalViewController, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath)
        -> CGFloat
    {
        return cellHeight
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return items.count
    }
    
    
    //there Ill create custom cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier = "identifier"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        
        if cell == nil {
            cell = CustomCell(reuseIdentifier: identifier, stopStartListener:self)
            cell?.selectionStyle = .default
            cell?.backgroundColor = UIColor.init(red: 29/255, green: 30/255, blue: 62/255, alpha: 1)
            cell?.accessoryType = .disclosureIndicator
        }
        if items != [:] {
            let arrayOfItems:Array? = Array(self.items.values)
            if let currentItem = arrayOfItems?[indexPath.row] {
                
                if let customCell = cell as? CustomCell {
                    //customCell.setLabeltext(name: currentItem.name, score: "\(currentItem.score)")
                    customCell.setNewTimer(item:currentItem)
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
    
    func stopTimer(id:String)
    {
        self.stopStartListener.stopTimer(id: id)
    }
    
    func startTimer(id:String)
    {
        self.stopStartListener.startTimer(id: id)
    }
    
    func getNumberOfRowForItemID(id: String)
        -> Int
    {
        var counter:Int = 0
        for item in self.items {
            counter = counter + 1
            if item.key == id {
                break
            }
        }
        let numberOfRow = counter - 1
        return numberOfRow
    }
    
    func updateCellWithItem(id:String)
    {
        print("i will stop timer with id \(id)")
        // self.updateTimerWithID(id: id)
        let indexPath = IndexPath(item: self.getNumberOfRowForItemID(id: id), section: 0)
        
            tableView.reloadRows(at: [indexPath], with: .fade)
        
    }
    
    
    func makeSomeChanges(itemsAdded: [Item]?, itemsUpdated: [Item]?, itemsDeleted: [Item]?)
    {
        // self.items[itemsAdded.id] = itemsAdded
        
        
        self.tableView.beginUpdates()
        if itemsUpdated != nil {
            for item in itemsUpdated! {
                print(item.name)
                let indexPath = IndexPath(item: self.getNumberOfRowForItemID(id: item.id), section: 0)
                tableView.reloadRows(at: [indexPath], with: .fade)
            }
        }
        
        
        if itemsAdded != nil {
            for item in itemsAdded! {
              self.items[item.id] = item
               // self.tableView.indexpath
                let indexPath = IndexPath(item: 0, section: 0)
                self.tableView.insertRows(at: [indexPath], with: .fade)
                self.tableView.reloadData()
            }
        }
        self.tableView.endUpdates()
    }
    
    
    
}
