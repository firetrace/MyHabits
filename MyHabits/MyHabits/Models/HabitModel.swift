//
//  HabitModel.swift
//  MyHabits
//
//  Created by Admin on 20.01.2021.
//

import UIKit

struct HabitModel {
    
    let id: Int?
    var name: String
    var date: Date
    var color: UIColor
    
    var isNew: Bool { get { id == nil }}

    init() {
        self.id = nil
        self.name = ""
        self.date = Date()
        self.color = getColorStyle(style: .Orange)
    }
    
    init(name: String, date: Date, color: UIColor) {
        self.id = nil
        self.name = name
        self.date = date
        self.color = color
    }
    
    init(id: Int, name: String, date: Date, color: UIColor) {
        self.id = id
        self.name = name
        self.date = date
        self.color = color
    }
    
    func getHabit() -> Habit? {
        guard let index = id else {
            return nil
        }
        return HabitsStore.shared.habits[index]
    }
}
