//
//  HabitView.swift
//  MyHabits
//
//  Created by Александр Глазков on 14.01.2021.
//

import UIKit

class HabitView: UIView {

    var data: HabitModel = HabitModel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
    }
}
