//
//  HabitModel.swift
//  MyHabits
//
//  Created by Александр Глазков on 14.01.2021.
//

import UIKit

struct HabitModel {
    private(set) var name: String?
    private(set) var date: Date?
    private(set) var color: UIColor?
    
    init() {
        self.name = nil
        self.date = nil
        self.color = nil
    }
    
    init(name: String, date: Date, color: UIColor) {
        self.name = name
        self.date = date
        self.color = color
    }
    
    mutating func updateName(_ name: String) {
        self.name = name
    }
    
    mutating func updateDate(_ date: Date) {
        self.date = date
    }
    
    mutating func updateColor(_ color: UIColor) {
        self.color = color
    }
}
