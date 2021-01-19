//
//  HabitCollectionViewCell.swift
//  MyHabits
//
//  Created by Александр Глазков on 15.01.2021.
//

import UIKit

class HabitCollectionViewCell: UICollectionViewCell {
    
    weak var thisDelegate: HabitProtocol?
    
    private var data: Habit? {
        didSet {
            nameLabel.text = data?.name
            nameLabel.textColor = data?.color
            dateLabel.text = data?.dateString
            
            updateCheckButton()
            updateDescriptionLabel()
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
        label.font = getFontStyle(style: .Footnote2)
        label.textColor = getColorStyle(style: .LightGray)
        label.toAutoLayout()
        
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        var label = UILabel(frame: .zero)
        label.font = getFontStyle(style: .Footnote1)
        label.textColor = getColorStyle(style: .Gray)
        label.toAutoLayout()
        
        return label
    }()
    
    private lazy var checkButton: UIButton = {
        var button = UIButton(frame: .zero)
        button.addTarget(self, action: #selector(checkHabit), for: .touchUpInside)
        button.tintColor = .systemBackground
        button.layer.cornerRadius = 18
        button.layer.borderWidth = 3
        button.clipsToBounds = true
        button.toAutoLayout()
        
        return button
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layoutUpdate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func checkHabit() {
        if let thisData = data, thisData.isAlreadyTakenToday == false {
            HabitsStore.shared.track(thisData)
            thisDelegate?.updateData()
        }
    }
    
    private func updateCheckButton() {
        if (data?.isAlreadyTakenToday != false) {
            checkButton.backgroundColor = data?.color
            checkButton.layer.borderColor = data?.color.cgColor
            checkButton.setImage(UIImage(systemName: "checkmark"), for: .normal)
        }
        else {
            checkButton.backgroundColor = nil
            checkButton.layer.borderColor = data?.color.cgColor
            checkButton.setImage(nil, for: .normal)
        }
    }
    
    private func updateDescriptionLabel() {
        var countConsecutiveDate = 0
        if let thisData = data {

            let sortedTrackDates = thisData.trackDates.sorted(by: { $0.compare($1) == .orderedDescending })
            for (index, date) in sortedTrackDates.enumerated() {
                if index + 1 < sortedTrackDates.count {
                    let currentDateComponents = Calendar.current.dateComponents([.day, .month, .year], from: date)
                    let nextDateComponents = Calendar.current.dateComponents([.day, .month, .year], from: sortedTrackDates[index + 1])
                    
                    if (currentDateComponents.year == nextDateComponents.year &&
                        currentDateComponents.month == nextDateComponents.month &&
                        (currentDateComponents.day ?? 0) - (nextDateComponents.day ?? 0) == 1) {
                        countConsecutiveDate += 1
                    }
                    else {
                        break
                    }
                }
            }
        }
        descriptionLabel.text = "Подряд: \(countConsecutiveDate)"
    }
}

extension HabitCollectionViewCell: CellProtocol {
    
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
                                     nameLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.7),
                                     
                                     dateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: topConst4),
                                     dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: leadingConst20),
                                     dateLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5),
                                     
                                     descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: leadingConst20),
                                     descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: bottomConst20),
                                     descriptionLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5),
                                                                          
                                     checkButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: trailingConst26),
                                     checkButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                                     checkButton.widthAnchor.constraint(equalToConstant: 36),
                                     checkButton.heightAnchor.constraint(equalToConstant: 36)])
    }
    
    func updateCell(object: Any) {
        if let habit = object as? Habit {
            self.data = habit
        }
    }
}
