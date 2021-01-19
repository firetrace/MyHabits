//
//  HabitView.swift
//  MyHabits
//
//  Created by Александр Глазков on 14.01.2021.
//

import UIKit

class HabitView: UIView {

    weak var thisDelegate: HabitProtocol?
    
    private var data: Habit? {
        didSet {
            nameText.text = data?.name
            colorButton.backgroundColor = data?.color
            datePicker.date = data?.date ?? Date()
            
            updateDateDescription()
        }
    }
    
    private var isEditMode: Bool = false {
        didSet {
            if (!isEditMode) {
                delButton.removeFromSuperview()
            }
        }
    }
            
    private lazy var nameLabel: UILabel = {
        var label = UILabel(frame: .zero)
        label.text = habitNameTitle
        label.font = getFontStyle(style: .Footnote1)
        label.setContentHuggingPriority(.required, for: .vertical)
        label.toAutoLayout()
        
        return label
    }()
    
    private lazy var nameText: UITextField = {
        var text = UITextField(frame: .zero)
        text.font = getFontStyle(style: .Body)
        text.placeholder = habitNamePlaceholder
        text.addTarget(self, action: #selector(updateName(_:)), for: .editingChanged)
        text.setContentHuggingPriority(.required, for: .vertical)
        text.toAutoLayout()
        
        return text
    }()
    
    private lazy var colorLabel: UILabel = {
        var label = UILabel(frame: .zero)
        label.text = habitColorTitle
        label.font = getFontStyle(style: .Footnote1)
        label.toAutoLayout()
        label.setContentHuggingPriority(.required, for: .vertical)
        
        return label
    }()
    
    private lazy var colorButton: UIButton = {
        var button = UIButton(frame: .zero)
        button.addTarget(self, action: #selector(updateColor), for: .touchUpInside)
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        button.setContentHuggingPriority(.required, for: .vertical)
        button.toAutoLayout()
        
        return button
    }()
    
    private lazy var dateLabel: UILabel = {
        var label = UILabel(frame: .zero)
        label.text = habitDateTitle
        label.font = getFontStyle(style: .Footnote1)
        label.setContentHuggingPriority(.required, for: .vertical)
        label.toAutoLayout()
        
        return label
    }()
    
    private lazy var dateDescriptionLabel: UILabel = {
        var label = UILabel(frame: .zero)
        label.setContentHuggingPriority(.required, for: .vertical)
        label.toAutoLayout()
        
        return label
    }()
    
    private lazy var datePicker: UIDatePicker = {
        var picker = UIDatePicker(frame: .zero)
        picker.preferredDatePickerStyle = .wheels
        picker.datePickerMode = .time
        picker.addTarget(self, action: #selector(updateDate(_:)), for: .valueChanged)
        picker.setContentHuggingPriority(.required, for: .vertical)
        picker.toAutoLayout()
        
        return picker
    }()
    
    private lazy var delButton: UIButton = {
        var button = UIButton(frame: .zero)
        button.addTarget(self, action: #selector(del), for: .touchUpInside)
        button.setTitle("Удалить привычку", for: .normal)
        button.titleLabel?.font = getFontStyle(style: .Body)
        button.setTitleColor(.red, for: .normal)
        button.setContentHuggingPriority(.required, for: .vertical)
        button.toAutoLayout()
        
        return button
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
        if (!isEditMode) {
            nameText.becomeFirstResponder()
        }
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(data: Habit?) {
        isEditMode = data != nil
        self.data = Habit(name: data?.name ?? "", date: data?.date ?? Date(), color: data?.color ?? getColorStyle(style: .Orange))
    }
    
    func getData() -> Habit? { data }
    
    private func setupLayout() {
        addSubview(nameLabel)
        addSubview(nameText)
        addSubview(colorLabel)
        addSubview(colorButton)
        addSubview(dateLabel)
        addSubview(dateDescriptionLabel)
        addSubview(datePicker)
        addSubview(delButton)
        
        let datePickerBottom = datePicker.bottomAnchor.constraint(equalTo: bottomAnchor)
        datePickerBottom.priority = .defaultLow
        
        NSLayoutConstraint.activate([nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: topConst22),
                                     nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leadingConst16),
                                     nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: trailingConst16),
                                     
                                     nameText.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: topConst7),
                                     nameText.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leadingConst16),
                                     nameText.trailingAnchor.constraint(equalTo: trailingAnchor, constant: trailingConst16),
                                     
                                     colorLabel.topAnchor.constraint(equalTo: nameText.bottomAnchor, constant: topConst15),
                                     colorLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leadingConst16),
                                     colorLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: trailingConst16),
                                     
                                     colorButton.topAnchor.constraint(equalTo: colorLabel.bottomAnchor, constant: topConst7),
                                     colorButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leadingConst16),
                                     colorButton.widthAnchor.constraint(equalToConstant: 30),
                                     colorButton.heightAnchor.constraint(equalToConstant: 30),
                                     
                                     dateLabel.topAnchor.constraint(equalTo: colorButton.bottomAnchor, constant: topConst15),
                                     dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leadingConst16),
                                     dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: trailingConst16),
                                     
                                     dateDescriptionLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: topConst7),
                                     dateDescriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leadingConst16),
                                     dateDescriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: trailingConst16),
                                     
                                     datePicker.topAnchor.constraint(equalTo: dateDescriptionLabel.bottomAnchor, constant: topConst15),
                                     datePicker.leadingAnchor.constraint(equalTo: leadingAnchor),
                                     datePicker.trailingAnchor.constraint(equalTo: trailingAnchor),
                                     datePickerBottom,
                                                                          
                                     delButton.centerXAnchor.constraint(equalTo: centerXAnchor),
                                     delButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: bottomConst8)])
    }
    
    @objc private func updateName(_ textField: UITextField) {
        data?.name = textField.text ?? ""
    }
    
    @objc private func updateColor() {
        let picker = UIColorPickerViewController()
        picker.selectedColor = data?.color ?? getColorStyle(style: .Orange)
        picker.delegate = self
        
        thisDelegate?.presentController(picker, animated: true, completion: nil)
    }
    
    @objc private func updateDate(_ datePicker: UIDatePicker) {
        if let thisData = data, thisData.date != datePicker.date {
            thisData.date = datePicker.date
            updateDateDescription()
        }
    }

    @objc private func del() {
        weak var weakSelf = self
        let alert = UIAlertController(title: "Удалить привычку",
                                      message: "Вы хотите удалить привычку \"\(String(describing: data?.name ?? ""))\"?",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Удалить", style: .destructive, handler: { (action) in
            if let thisData = weakSelf?.data, let index = HabitsStore.shared.habits.firstIndex(of: thisData) {
                HabitsStore.shared.habits.remove(at: index)
            }
            weakSelf?.thisDelegate?.dismissController(animated: true, completion: nil)
        }))
        
        thisDelegate?.presentController(alert, animated: true, completion: nil)
    }
    
    private func updateDateDescription(){
        if let thisData = data {
            let baseStr = NSMutableAttributedString(string: habitDateDescriptionPattern,
                                                    attributes: [NSAttributedString.Key.font: getFontStyle(style: .Body)])
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            
            let dateStr = NSAttributedString(string: formatter.string(from: thisData.date),
                                             attributes: [NSAttributedString.Key.font: getFontStyle(style: .Body),
                                                          NSAttributedString.Key.foregroundColor: getColorStyle(style: .Magenta)])
            baseStr.append(dateStr)
            dateDescriptionLabel.attributedText = baseStr
        }
    }
}

extension HabitView: UIColorPickerViewControllerDelegate {
    
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        if let thisData = data, thisData.color != viewController.selectedColor {
            thisData.color = viewController.selectedColor
            colorButton.backgroundColor = thisData.color
        }
    }
}
