//
//  TrackedDayTableViewCell.swift
//  TestOneTrak
//
//  Created by Ivan Stebletsov on 15/02/2019.
//  Copyright © 2019 Ivan Stebletsov. All rights reserved.
//

import UIKit

class TrackedDayTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    var cellWidth: CGFloat!
    var bottomOfSetFromBottomCountersLabelsStackView: NSLayoutConstraint!
    
    // MARK: - UI elements
    private var topCellElementsStackView: UIStackView!
    var dateLabel: UILabel!
    var totalStepsCounterLabel: UILabel!
    
    private weak var countersStackView: UIStackView!
    var walkProgressView: UIView!
    var aerobicProgressView: UIView!
    var runProgressView: UIView!
    
    private var bottomCountersStackView: UIStackView!
    var walkStepsCounterLabel: UILabel!
    var aerobicStepsCounterLabel: UILabel!
    var runStepsCounterLabel: UILabel!
    private var bottomCountersLabelsStackView: UIStackView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupTopCellElements()
        setupBottomCellElements()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI configuration
    func setupTopCellElements() {
        topCellElementsStackView = UIStackView()
        topCellElementsStackView.translatesAutoresizingMaskIntoConstraints = false
        topCellElementsStackView.distribution = .fillEqually
        
        self.addSubview(topCellElementsStackView)
        
        let topCellElementsStackViewConstraints = [
            topCellElementsStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            topCellElementsStackView.heightAnchor.constraint(equalToConstant: 20),
            topCellElementsStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            topCellElementsStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15)]
        NSLayoutConstraint.activate(topCellElementsStackViewConstraints)
        
        dateLabel = UILabel()
        dateLabel.textAlignment = .left
        dateLabel.font = .systemFont(ofSize: 20)
        
        topCellElementsStackView.addArrangedSubview(dateLabel)
        
        totalStepsCounterLabel = UILabel()
        totalStepsCounterLabel.textAlignment = .right
        totalStepsCounterLabel.font = .systemFont(ofSize: 20)
        
        topCellElementsStackView.addArrangedSubview(totalStepsCounterLabel)
    }
    
    func setupProgressViews(walkShare: CGFloat, aerobicShare: CGFloat, runShare: CGFloat) {
        let totalWidthOfProgressViewWitoutSpacing = cellWidth - 38
        
        let widthOfWlakProgressView = (totalWidthOfProgressViewWitoutSpacing * walkShare).rounded()
        walkProgressView = UIView(frame: CGRect(x: 15, y: 50, width: 0, height: 8))
        walkProgressView.roundCorners(corners: [.layerMinXMaxYCorner, .layerMinXMinYCorner], radius: walkProgressView.frame.height / 2)
        walkProgressView.layer.shouldRasterize = true
        walkProgressView.layer.rasterizationScale = UIScreen.main.nativeScale
        walkProgressView.translatesAutoresizingMaskIntoConstraints = false
        walkProgressView.backgroundColor = #colorLiteral(red: 0.6916202903, green: 0.8898550272, blue: 0.9489519, alpha: 1)
        
        self.addSubview(walkProgressView)
        
        UIView.animate(withDuration: 0.8,
                       delay: 0,
                       options: .curveEaseOut,
                       animations: {
                        self.walkProgressView.frame = CGRect(x: 15, y: 50, width: widthOfWlakProgressView, height: 8) },
                       completion: nil)
        
        let widthOfAerobicProgressView = (totalWidthOfProgressViewWitoutSpacing * aerobicShare).rounded()
        aerobicProgressView = UIView(frame: CGRect(x: walkProgressView.frame.width + 19, y: 50, width: 0, height: 8))
        aerobicProgressView.translatesAutoresizingMaskIntoConstraints = false
        aerobicProgressView.backgroundColor = #colorLiteral(red: 0.3214670718, green: 0.7792814374, blue: 0.9011147618, alpha: 1)
        
        self.addSubview(aerobicProgressView)
        
        UIView.animate(withDuration: 0.8,
                       delay: 0.8,
                       options: .curveEaseOut,
                       animations: {
                        self.aerobicProgressView.frame = CGRect(x: self.walkProgressView.frame.width + 19, y: 50, width: widthOfAerobicProgressView, height: 8) },
                       completion: nil)
        
        let widthOfRunProgressView = (totalWidthOfProgressViewWitoutSpacing * runShare).rounded()
        runProgressView = UIView(frame: CGRect(x: walkProgressView.frame.width + aerobicProgressView.frame.width + 23, y: 50, width: 0, height: 8))
        runProgressView.roundCorners(corners: [.layerMaxXMaxYCorner, .layerMaxXMinYCorner], radius: runProgressView.frame.height / 2)
        runProgressView.layer.shouldRasterize = true
        runProgressView.layer.rasterizationScale = UIScreen.main.nativeScale
        runProgressView.translatesAutoresizingMaskIntoConstraints = false
        runProgressView.backgroundColor = #colorLiteral(red: 0.1993859112, green: 0.5129492283, blue: 0.5969568491, alpha: 1)
        
        self.addSubview(runProgressView)
        
        UIView.animate(withDuration: 0.8,
                       delay: 1.6,
                       options: .curveEaseOut,
                       animations: {
                        self.runProgressView.frame = CGRect(x: self.walkProgressView.frame.width + self.aerobicProgressView.frame.width + 23, y: 50, width: widthOfRunProgressView, height: 8) },
                       completion: nil)
    }
    
    func setupBottomCellElements() {
        // Setup stackView for counters
        bottomCountersStackView = UIStackView()
        bottomCountersStackView.distribution = .fillEqually
        bottomCountersStackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(bottomCountersStackView)
        
        let bottomCountersStackViewConstraints = [
            bottomCountersStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 74),
            bottomCountersStackView.heightAnchor.constraint(equalToConstant: 18),
            bottomCountersStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            bottomCountersStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),]
        NSLayoutConstraint.activate(bottomCountersStackViewConstraints)
        
        walkStepsCounterLabel = UILabel()
        walkStepsCounterLabel.textAlignment = .center
        walkStepsCounterLabel.font = .systemFont(ofSize: 18)
        walkStepsCounterLabel.translatesAutoresizingMaskIntoConstraints = false
        
        bottomCountersStackView.addArrangedSubview(walkStepsCounterLabel)
        
        aerobicStepsCounterLabel = UILabel()
        aerobicStepsCounterLabel.textAlignment = .center
        aerobicStepsCounterLabel.font = .systemFont(ofSize: 18)
        aerobicStepsCounterLabel.translatesAutoresizingMaskIntoConstraints = false
        
        bottomCountersStackView.addArrangedSubview(aerobicStepsCounterLabel)
        
        runStepsCounterLabel = UILabel()
        runStepsCounterLabel.textAlignment = .center
        runStepsCounterLabel.font = .systemFont(ofSize: 18)
        runStepsCounterLabel.translatesAutoresizingMaskIntoConstraints = false
        
        bottomCountersStackView.addArrangedSubview(runStepsCounterLabel)
        
        // Setup stackView for labels of counters by type
        bottomCountersLabelsStackView = UIStackView()
        bottomCountersLabelsStackView.distribution = .fillEqually
        bottomCountersLabelsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(bottomCountersLabelsStackView)
        
        let bottomCountersLabelsStackViewConstraints = [
            bottomCountersLabelsStackView.topAnchor.constraint(equalTo: bottomCountersStackView.bottomAnchor, constant: 1),
            bottomCountersLabelsStackView.heightAnchor.constraint(equalToConstant: 14),
            bottomCountersLabelsStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15),
            bottomCountersLabelsStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            bottomCountersLabelsStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15)]
        NSLayoutConstraint.activate(bottomCountersLabelsStackViewConstraints)
        
        let walkBottomLabel = UILabel()
        walkBottomLabel.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        walkBottomLabel.translatesAutoresizingMaskIntoConstraints = false
        walkBottomLabel.text = "walk"
        walkBottomLabel.textAlignment = .center
        walkBottomLabel.font = .systemFont(ofSize: 14)
        
        bottomCountersLabelsStackView.addArrangedSubview(walkBottomLabel)
        
        let aerobicBottomLabel = UILabel()
        aerobicBottomLabel.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        aerobicBottomLabel.translatesAutoresizingMaskIntoConstraints = false
        aerobicBottomLabel.text = "aerobic"
        aerobicBottomLabel.textAlignment = .center
        aerobicBottomLabel.font = .systemFont(ofSize: 14)
        
        bottomCountersLabelsStackView.addArrangedSubview(aerobicBottomLabel)
        
        let runBottomLabel = UILabel()
        runBottomLabel.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        runBottomLabel.translatesAutoresizingMaskIntoConstraints = false
        runBottomLabel.text = "run"
        runBottomLabel.textAlignment = .center
        runBottomLabel.font = .systemFont(ofSize: 14)
        
        bottomCountersLabelsStackView.addArrangedSubview(runBottomLabel)
    }
}
