//
//  HabitModel.swift
//  MyHabits
//
//  Created by Александр Глазков on 14.01.2021.
//

import UIKit

struct HabitModel {
    
    weak var delegate: HabitProtocol?
    
    private(set) var name: String? {
        didSet {
            if let thisName = name {
                delegate?.changeName(thisName)
            }
        }
    }
    private(set) var date: Date? {
        didSet {
            if let thisDate = date {
                delegate?.changeDate(thisDate)
            }
        }
    }
    private(set) var color: UIColor? {
        didSet {
            if let thisColor = color {
                delegate?.changeColor(thisColor)
            }
        }
    }
    private(set) var dateCheck: Date? {
        didSet {
            delegate?.changeCheck()
        }
    }
    
    init() {
        self.name = nil
        self.date = nil
        self.color = nil
        self.dateCheck = nil
    }
        
    mutating func updateName(_ name: String?) {
        self.name = name
    }
    
    mutating func updateDate(_ date: Date?) {
        self.date = date
    }
    
    mutating func updateColor(_ color: UIColor?) {
        self.color = color
    }
    
    mutating func updateDateCheck(_ date: Date?) {
        self.dateCheck = date
    }
}
