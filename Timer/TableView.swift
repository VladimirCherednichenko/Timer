//
//  TabelView.swift
//  
//
//  Created by Vladimir Cherednichenko on 17.08.17.
//

import Foundation
import UIKit

class TabelView:UITableViewController
{
    
    var items:[String:Item]
    var cellHeight:CGFloat = 100
    
    init(items:[String:Item])
    {
        self.items = items
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.barTintColor = UIColor.gray
    }
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableView.reloadData()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addTupped))
    }
    
    @objc func addTupped()
    {
        let addTimerModalViewController = AddTimerModalViewController()
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
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier = "identifier"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        
        if cell == nil {
            cell = CustomCell(reuseIdentifier: identifier)
            cell?.selectionStyle = .default
            cell?.backgroundColor = UIColor.darkGray
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
      //  listener.stopTimer(id: id)
    }
    
    func startTimer(id:String)
    {
       // listener.startTimer(id: id)
    }
    
    func getNumberOfRowForItemID(id: String)
        -> Int
    {
        
        var counter:Int = 0
        if let items:[String:Item] = items {
            for item in items {
                counter = counter + 1
                if item.key == id {
                    break
                }
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
        
        if indexPath.item < 6 {
            tableView.reloadRows(at: [indexPath], with: .fade)
        }
        
        
    }
    
}
