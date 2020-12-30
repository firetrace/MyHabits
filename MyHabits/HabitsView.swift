//
//  HabitsView.swift
//  MyHabits
//
//  Created by Admin on 30.12.2020.
//

import UIKit

class HabitsView: UIView {
    
    enum TypeHabitsView {
        case Title
        case Button
    }
    
    private var type: TypeHabitsView = .Title
    
    private lazy var addButton: UIButton = {
        var button = UIButton()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = getColorStyle(style: .Magenta)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var headerLabel: UILabel = {
        var label = UILabel()
        label.text = "Сегодня"
        label.font = getFontStyle(style: .Title)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    convenience init(type: TypeHabitsView) {
        self.init(frame: .zero)
        self.type = type
        self.setupLayout()
    }
            
    func setupLayout() {

        translatesAutoresizingMaskIntoConstraints = false
        
        if (type == .Title) {
            addSubview(headerLabel)
            
            NSLayoutConstraint.activate([headerLabel.topAnchor.constraint(equalTo: topAnchor),
                                         headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
                                         headerLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
                                         headerLabel.bottomAnchor.constraint(equalTo: bottomAnchor)])
        } else {
            addSubview(addButton)
            
            NSLayoutConstraint.activate([addButton.topAnchor.constraint(equalTo: topAnchor),
                                         addButton.leadingAnchor.constraint(equalTo: leadingAnchor),
                                         addButton.trailingAnchor.constraint(equalTo: trailingAnchor),
                                         addButton.bottomAnchor.constraint(equalTo: bottomAnchor)])
        }
    }
}
