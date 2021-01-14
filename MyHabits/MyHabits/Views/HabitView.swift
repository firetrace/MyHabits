//
//  HabitView.swift
//  MyHabits
//
//  Created by Александр Глазков on 14.01.2021.
//

import UIKit

class HabitView: UIView {

    weak var thisDelegate: HabitProtocol?
    
    lazy var data: HabitModel =  {
        var model = HabitModel()
        model.delegate = self
        model.updateColor(getColorStyle(style: .Orange))
        
        return model
    }()
        
    private lazy var nameLabel: UILabel = {
        var label = UILabel(frame: .zero)
        label.text = habitNameTitle
        label.font = getFontStyle(style: .Footnote1)
        label.toAutoLayout()
        
        return label
    }()
    
    private lazy var nameText: UITextField = {
        var text = UITextField(frame: .zero)
        text.font = getFontStyle(style: .Body)
        text.placeholder = "Test"
        text.addTarget(self, action: #selector(updateName(_:)), for: .editingChanged)
        text.toAutoLayout()
        
        return text
    }()
    
    private lazy var colorLabel: UILabel = {
        var label = UILabel(frame: .zero)
        label.text = habitColorTitle
        label.font = getFontStyle(style: .Footnote1)
        label.toAutoLayout()
        
        return label
    }()
    
    private lazy var colorButton: UIButton = {
        var button = UIButton(frame: .zero)
        button.addTarget(self, action: #selector(updateColor), for: .touchUpInside)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemBackground.cgColor
        button.layer.cornerRadius = 100/2
        button.layer.masksToBounds = true
        button.toAutoLayout()
        
        return button
    }()
    
    private lazy var dateLabel: UILabel = {
        var label = UILabel(frame: .zero)
        label.text = habitDateTitle
        label.font = getFontStyle(style: .Footnote1)
        label.toAutoLayout()
        
        return label
    }()
    
    private lazy var dateDescriptionLabel: UILabel = {
        var label = UILabel(frame: .zero)
        label.text = habitDateTitle
        label.font = getFontStyle(style: .Footnote1)
        label.toAutoLayout()
        
        return label
    }()
    
    private lazy var datePicker: UIDatePicker = {
        var picker = UIDatePicker(frame: .zero)
        picker.datePickerMode = .time
        picker.addTarget(self, action: #selector(updateDate(_:)), for: .touchUpInside)
        picker.toAutoLayout()
        
        return picker
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        
    }
    
    @objc private func updateName(_ textField: UITextField) {
        data.updateName(textField.text)
    }
    
    @objc private func updateColor() {
        guard let delegate = thisDelegate else {
            return
        }
        
        delegate.changeColor(colorButton.backgroundColor ?? getColorStyle(style: .Orange))
    }
    
    @objc private func updateDate(_ datePicker: UIDatePicker) {
        data.updateDate(datePicker.date)
    }
}


extension HabitView : HabitProtocol {
    
    func changeColor(_ color: UIColor) {
        colorButton.backgroundColor = color
    }
    
    func changeDate(_ date: Date) {
        
    }
}
