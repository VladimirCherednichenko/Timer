//
//  TabelView.swift
//  Timer
//
//  Created by Vladimir on 06.07.17.
//  Copyright © 2017 Vladimir. All rights reserved.
//

import Foundation
import UIKit

class TimeTableViewController:UITableViewController
{
    private var timerTableViewDataSourse = TimerTableViewDataSource()
    
    
    init(items:[String:Item]?, startTimeListener:StartTimeListener)
    {
        super.init(nibName: nil, bundle: nil)
        self.timerTableViewDataSourse.items = items
        self.timerTableViewDataSourse.startTimeListener = startTimeListener
    }
    required init?(coder aDecoder: NSCoder) {
        print("init coder style")
        super.init(coder: aDecoder)
        
    }
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableView.dataSource = self.timerTableViewDataSourse
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath)
        -> CGFloat
    {
        return 100
    }
}


