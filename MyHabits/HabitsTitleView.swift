//
//  HabitsView.swift
//  MyHabits
//
//  Created by Admin on 30.12.2020.
//

import UIKit

class HabitsTitleView: UIView {
    
    private lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.text = "Сегодня"
        label.font = getFontStyle(style: .Title)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(titleLabel)
        NSLayoutConstraint.activate([titleLabel.topAnchor.constraint(equalTo: topAnchor),
                                     titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
                                     titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
                                     titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)])
    }
}
