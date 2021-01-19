//
//  HabitDetailsView.swift
//  MyHabits
//
//  Created by Admin on 19.01.2021.
//

import UIKit

class HabitDetailsView: UIView {
    
    var data: Habit?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
