//
//  HabitCollectionViewCell.swift
//  MyHabits
//
//  Created by Александр Глазков on 15.01.2021.
//

import UIKit

class HabitCollectionViewCell: UICollectionViewCell {
    
    weak var thisDelegate: HabitsProtocol?
    
    private var data: Habit? {
        didSet {
            nameLabel.text = data?.name
            nameLabel.textColor = data?.color
            dateLabel.text = data?.dateString
            
            if (data?.isAlreadyTakenToday != false) {
                checkButton.backgroundColor = data?.color
                checkButton.tintColor = .systemBackground
                checkButton.setImage(UIImage(systemName: "checkmark"), for: .normal)
            }
            else {
                checkButton.layer.borderWidth = 3
                checkButton.layer.borderColor = data?.color.cgColor
            }
            
            var countConsecutiveDate = 0
            if let sortedTrackDates = data?.trackDates.sorted(by: { $0.compare($1) == .orderedDescending }) {
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
            }
            descriptionLabel.text = "Подряд: \(countConsecutiveDate)"
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
        
        layoutUpdate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func checkHabit() {
        guard let thisData = data else {
            return
        }
        
        if (thisData.isAlreadyTakenToday == false) {
            checkButton.backgroundColor = data?.color
            checkButton.tintColor = .systemBackground
            checkButton.setImage(UIImage(systemName: "checkmark"), for: .normal)
            
            HabitsStore.shared.track(thisData)
            
            thisDelegate?.updateData()
        }
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
                                     nameLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.6),
                                     
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
