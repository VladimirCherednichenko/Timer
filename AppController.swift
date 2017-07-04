//
//  File.swift
//  Timer
//
//  Created by Vladimir on 30.06.17.
//  Copyright © 2017 Vladimir. All rights reserved.
//

import Foundation
import UIKit

class ApplicationController
{
    private var navigationController: UINavigationController
    
    init(navigationController: UINavigationController)
    {
        self.navigationController = navigationController
        showJobsViewController()
    }
    
    func showJobsViewController()
    {
        let jobsViewController = JobsViewController()
        navigationController.setViewControllers([jobsViewController], animated: false)
    }
    
    
}
