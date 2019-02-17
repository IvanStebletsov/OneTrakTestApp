//
//  StepsTrackingViewController.swift
//  TestOneTrak
//
//  Created by Ivan Stebletsov on 15/02/2019.
//  Copyright © 2019 Ivan Stebletsov. All rights reserved.
//

import UIKit

class StepsTrackingViewController: UIViewController {
    
    // MARK: - Properties
    let mainCellId = "mainCell"
    let goalReachedCellId = "goalReachedCell"
    var stepsGoal: Int?
    var trackedDays = [TrackedDay]()
    var activityIndicator: UIActivityIndicatorView!
    let apiUrl = "https://intern-f6251.firebaseio.com/intern/metric.json"
    
    // MARK: - UI elements
    var stepsTrackingTableView: UITableView!
    
    // MARK: - Life cicle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        loadStepsGoal()
        
        if stepsGoal == 0 {
            addNewGoal()
        } else {
            fetchData()
        }
        
        setupStepsTrackingTableView()
        addAimNavigationBarButton()
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        stepsTrackingTableView.reloadData()
    }
}
