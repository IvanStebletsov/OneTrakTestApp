//
//  StepsTrackingVCExtension.swift
//  TestOneTrak
//
//  Created by Ivan Stebletsov on 15/02/2019.
//  Copyright © 2019 Ivan Stebletsov. All rights reserved.
//

import UIKit

extension StepsTrackingViewController {
    
    // MARK: - UI configuration
    func setupStepsTrackingTableView() {
        navigationItem.title = "Steps"
        
        stepsTrackingTableView = UITableView()
        stepsTrackingTableView.translatesAutoresizingMaskIntoConstraints = false
        stepsTrackingTableView.backgroundColor = #colorLiteral(red: 0.9095756412, green: 0.9136518836, blue: 0.9218249917, alpha: 1)
        stepsTrackingTableView.separatorStyle = .none
        stepsTrackingTableView.allowsSelection = false
        stepsTrackingTableView.rowHeight = UITableView.automaticDimension
        stepsTrackingTableView.estimatedRowHeight = 121
        
        stepsTrackingTableView.delegate = self
        stepsTrackingTableView.dataSource = self
        
        stepsTrackingTableView.register(TrackedDayTableViewCell.self, forCellReuseIdentifier: mainCellId)
        stepsTrackingTableView.register(GoalReachedTableViewCell.self, forCellReuseIdentifier: goalReachedCellId)
        
        view.addSubview(stepsTrackingTableView)
        
        let stepsTrackingTableViewConstraints = [
            stepsTrackingTableView.topAnchor.constraint(equalTo: view.topAnchor),
            stepsTrackingTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            stepsTrackingTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stepsTrackingTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)]
        NSLayoutConstraint.activate(stepsTrackingTableViewConstraints)
    }
    
    func addAimNavigationBarButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "icon_aim"),
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(addNewGoal))
        navigationItem.leftBarButtonItem?.tintColor = #colorLiteral(red: 0.4721767902, green: 0.8227933049, blue: 0.9196507931, alpha: 1)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "icon_plus"),
                                                            style: .plain,
                                                            target: nil,
                                                            action: nil)
        navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0.416898908, green: 0.7313030613, blue: 0.8248697017, alpha: 1)
    }
    
    // MARK: - Helpers
    // This function help get share of progressView segment for type of steps
    func calculateViewShareForProgressView(_ totalSteps: Int, stepsOfType: Int) -> CGFloat {
        let stepsShare = Double(stepsOfType) / Double(totalSteps)
        return stepsShare.roundAndConvertToCGFloat()
    }
    
    func loadStepsGoal() {
        let defaults = UserDefaults.standard
        let loadedValue = defaults.integer(forKey: "stepsGoal")
        stepsGoal = loadedValue
    }
    
    func showActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(style: .gray)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 46, height: 46)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)])
        
        activityIndicator.startAnimating()
    }
    
    func hidectivityIndicator() {
        if activityIndicator != nil {
            activityIndicator.stopAnimating()
            
            NSLayoutConstraint.deactivate([
                activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)])
            
            activityIndicator.removeFromSuperview()
        }
    }
    
    // MARK: - Actions for Buttons
    @objc func addNewGoal() {
        let alertController = UIAlertController(title: "Установка новой цели",
                                                message: "Установите в качесвте цели количесвто шагов, которые Вы хотите проходить каждый день.",
                                                preferredStyle: .alert)
        
        alertController.addTextField { [unowned self] (textField) in
            textField.placeholder = "Введите количесвто шагов"
            textField.keyboardType = .numberPad
            guard let stepsGoal = self.stepsGoal else { return }
            textField.text = String(stepsGoal)
        }
        
        let okAlertAction = UIAlertAction(title: "Добавить", style: .default) { [unowned self] (action) in
            guard let textField = alertController.textFields?.first, let newGoal = Int(textField.text!) else { return }
            self.stepsGoal = newGoal
            
            let defaults = UserDefaults.standard
            defaults.set(newGoal, forKey: "stepsGoal")
            
            self.fetchData()
        }
        
        let cancelAlertAction = UIAlertAction(title: "Отменить", style: .default)
        
        alertController.addAction(cancelAlertAction)
        alertController.addAction(okAlertAction)
        
        self.present(alertController, animated: true)
    }
    
    // MARK: -  Work with network and API
    func fetchData() {
        self.showActivityIndicator()
        guard let url = URL(string: apiUrl) else { return }
        let session = URLSession.shared
        
        DispatchQueue.global().async {
            session.dataTask(with: url) { (data, _, _) in
                guard let data = data else { return }
                do {
                    let trackedDay = try JSONDecoder().decode([TrackedDay].self, from: data)
                    self.parseData(from: trackedDay)
                    DispatchQueue.main.async { [unowned self] in
                        self.hidectivityIndicator()
                        self.stepsTrackingTableView.reloadData()
                    }
                } catch { print(error) }
                }.resume()
        }
    }
    
    func parseData(from trackedDays: [TrackedDay]) {
        self.trackedDays.removeAll()
        for day in trackedDays {
            self.trackedDays.append(TrackedDay(aerobic: day.aerobic,
                                               date: day.date,
                                               run: day.run,
                                               walk: day.walk))
        }
    }
}
