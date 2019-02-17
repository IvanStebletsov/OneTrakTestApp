//
//  StepsTrackingTableViewProtocols.swift
//  TestOneTrak
//
//  Created by Ivan Stebletsov on 15/02/2019.
//  Copyright © 2019 Ivan Stebletsov. All rights reserved.
//

import UIKit

extension StepsTrackingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return trackedDays.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 0))
        headerView.backgroundColor = .clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let trackedDayForCell = trackedDays[section]
        let totalStepsCount = trackedDayForCell.walk + trackedDayForCell.aerobic + trackedDayForCell.run
        
        if let stepsGoal = stepsGoal, totalStepsCount >= stepsGoal {
            return 2
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let mainCell = tableView.dequeueReusableCell(withIdentifier: mainCellId, for: indexPath) as! TrackedDayTableViewCell
        let goalReachedCell = tableView.dequeueReusableCell(withIdentifier: goalReachedCellId, for: indexPath) as! GoalReachedTableViewCell
        
        // Configure te mainCell
        let trackedDayForCell = trackedDays[indexPath.section]
        mainCell.dateLabel.text = trackedDayForCell.date.converTimeFromUnixFormat()
        
        // Configure the stepCounterLabel
        let totalStepsCount = trackedDayForCell.walk + trackedDayForCell.aerobic + trackedDayForCell.run
        
        mainCell.totalStepsCounterLabel.text = stepsGoal != nil ? "\(totalStepsCount) / \(stepsGoal!)" : "\(totalStepsCount) / \(0)"
        
        // Setup and configure the pogressViews
        let walkStepsShare = calculateViewShareForProgressView(totalStepsCount, stepsOfType: trackedDayForCell.walk)
        let aerobicStepsShare = calculateViewShareForProgressView(totalStepsCount, stepsOfType: trackedDayForCell.aerobic)
        let runStepsShare = 1 - walkStepsShare - aerobicStepsShare
        
        mainCell.cellWidth = tableView.frame.width.rounded()
        mainCell.setupProgressViews(walkShare: walkStepsShare, aerobicShare: aerobicStepsShare, runShare: runStepsShare)
        
        mainCell.walkStepsCounterLabel.text = String(trackedDayForCell.walk)
        mainCell.aerobicStepsCounterLabel.text = String(trackedDayForCell.aerobic)
        mainCell.runStepsCounterLabel.text = String(trackedDayForCell.run)
        
        if let stepsGoal = stepsGoal, totalStepsCount >= stepsGoal {
            switch indexPath.row {
            case 1:
                return goalReachedCell
            default:
                return mainCell
            }
        } else {
            return mainCell
        }
    }
}
