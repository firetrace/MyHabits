//
//  HabitCollectionViewCell.swift
//  MyHabits
//
//  Created by Александр Глазков on 15.01.2021.
//

import UIKit

class HabitCollectionViewCell: UICollectionViewCell {
    
    private var data: HabitModel = HabitModel()
    private var habit: Habit? {
        didSet {
            data.updateName(habit?.name)
            data.updateColor(habit?.color)
            data.updateDate(habit?.date)
            data.updateDateCheck(habit?.trackDates.last)
        }
    }
    
    private lazy var nameLabel: UILabel = {
        var label = UILabel(frame: .zero)
        label.numberOfLines = 2
        label.font = getFontStyle(style: .Headline)
        label.toAutoLayout()
        
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        var label = UILabel(frame: .zero)
        label.font = getFontStyle(style: .Body)
        label.textColor = getColorStyle(style: .LightGray)
        label.toAutoLayout()
        
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        var label = UILabel(frame: .zero)
        label.font = getFontStyle(style: .Body)
        label.textColor = getColorStyle(style: .Gray)
        label.toAutoLayout()
        
        return label
    }()
    
    private lazy var checkButton: UIButton = {
        var button = UIButton(frame: .zero)
        button.addTarget(self, action: #selector(checkHabit), for: .touchUpInside)
        button.layer.cornerRadius = 18
        button.clipsToBounds = true
        button.toAutoLayout()
        
        return button
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        data.delegate = self        
        layoutUpdate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func checkHabit() {
        
    }
}

extension HabitCollectionViewCell: ViewCellProtocol {
    
    static var reuseId: String { String(describing: self) }
            
    func layoutUpdate() {
        contentView.backgroundColor = .systemBackground
        contentView.layer.cornerRadius = 8
        contentView.clipsToBounds = true
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(checkButton)
                
        NSLayoutConstraint.activate([nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: topConst20),
                                     nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: leadingConst20),
                                     nameLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5),
                                     
                                     dateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: topConst4),
                                     dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: leadingConst20),
                                     dateLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5),
                                     
                                     descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: leadingConst20),
                                     descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: bottomConst20),
                                     descriptionLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5),
                                                                          
                                     checkButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: trailingConst26),
                                     checkButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                                     checkButton.widthAnchor.constraint(equalToConstant: 36),
                                     checkButton.heightAnchor.constraint(equalToConstant: 36),
        ])
    }
    
    func updateCell(object: Any) {
        if let habit = object as? Habit {
            self.habit = habit
        }
    }
}

extension HabitCollectionViewCell: HabitProtocol {
    
    func changeName(_ name: String) {
        nameLabel.text = habit?.name
    }
    
    func changeColor(_ color: UIColor) {
        nameLabel.textColor = habit?.color
    }
    
    func changeDate(_ date: Date) {
        dateLabel.text = habit?.dateString
    }
    
    func changeCheck() {
        guard let thisHabit = habit else {
            return
        }
        
        if (thisHabit.isAlreadyTakenToday) {
            checkButton.backgroundColor = thisHabit.color
            checkButton.tintColor = .systemBackground
            checkButton.setImage(UIImage(systemName: "checkmark"), for: .normal)
        }
        else {
            checkButton.layer.borderWidth = 3
            checkButton.layer.borderColor = thisHabit.color.cgColor
        }
        
        var countConsecutiveDate = 0
        let sortedTrackDates = thisHabit.trackDates.sorted { $0.compare($1) == .orderedDescending }
        for (index, date) in sortedTrackDates.enumerated() {
            if index + 1 < sortedTrackDates.count {
                if let days = Calendar.current.dateComponents([.day], from: date, to: sortedTrackDates[index + 1]).day, days > 1 {
                    countConsecutiveDate += 1
                }
                else {
                    break
                }
            }
        }
        descriptionLabel.text = "Подряд: \(countConsecutiveDate)"
    }
}
