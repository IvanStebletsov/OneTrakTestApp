//
//  GoalReachedTableViewCell.swift
//  TestOneTrak
//
//  Created by Ivan Stebletsov on 17/02/2019.
//  Copyright © 2019 Ivan Stebletsov. All rights reserved.
//

import UIKit

class GoalReachedTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    var cellWidth: CGFloat!
    var bottomOfSetFromBottomCountersLabelsStackView: NSLayoutConstraint!
    
    var lineView: UIView!
    var goalReachedLabel: UILabel!
    var goalReachedImage: UIImageView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupGoalReachedElementsIf()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI configuration
    func setupGoalReachedElementsIf() {
        lineView = UIView()
        lineView.translatesAutoresizingMaskIntoConstraints = false
        lineView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        self.addSubview(lineView)
        
        goalReachedLabel = UILabel()
        goalReachedLabel.translatesAutoresizingMaskIntoConstraints = false
        goalReachedLabel.textAlignment = .left
        goalReachedLabel.font = .systemFont(ofSize: 20)
        goalReachedLabel.textColor = #colorLiteral(red: 0.2261454299, green: 0.593891866, blue: 0.6918370839, alpha: 1)
        goalReachedLabel.alpha = 0
        goalReachedLabel.text = "Goal reached"
        self.addSubview(goalReachedLabel)
        
        goalReachedImage = UIImageView()
        goalReachedImage.translatesAutoresizingMaskIntoConstraints = false
        goalReachedImage.image = UIImage(named: "icon_star")
        goalReachedImage.alpha = 0
        self.addSubview(goalReachedImage)
       
        let lineViewConstraonts = [
            lineView.topAnchor.constraint(equalTo: self.topAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 1),
            lineView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            lineView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15)]
        NSLayoutConstraint.activate(lineViewConstraonts)
        
        let goalReachedLabelConstraints = [
            goalReachedLabel.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 15),
            goalReachedLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            goalReachedLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15)]
        NSLayoutConstraint.activate(goalReachedLabelConstraints)
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       options: .curveEaseInOut,
                       animations: { [unowned self] in
                        self.goalReachedLabel.alpha = 1 })
        
        let goalReachedImageConstraints = [
            goalReachedImage.centerYAnchor.constraint(equalTo: goalReachedLabel.centerYAnchor),
            goalReachedImage.widthAnchor.constraint(equalTo: goalReachedImage.heightAnchor),
            goalReachedImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15)]
        NSLayoutConstraint.activate(goalReachedImageConstraints)
        
        UIView.animate(withDuration: 0.5,
                       delay: 0.5,
                       options: [.curveEaseInOut],
                       animations: { [unowned self] in
                        self.goalReachedImage.alpha = 1
                        self.goalReachedImage.layer.shadowColor = UIColor.black.cgColor
                        self.goalReachedImage.layer.shadowOpacity = 0.3
                        self.goalReachedImage.layer.shadowRadius = 2
                        self.goalReachedImage.layer.shadowOffset = CGSize(width: 0, height: 4)
                        self.goalReachedImage.transform = CGAffineTransform(scaleX: 0.9, y: 0.9) })
    }
}
