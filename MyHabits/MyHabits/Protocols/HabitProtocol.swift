//
//  HabitProtocol.swift
//  MyHabits
//
//  Created by Александр Глазков on 14.01.2021.
//

import UIKit

protocol HabitProtocol: AnyObject {
    func changeName(_ name: String)
    func changeColor(_ color: UIColor)
    func changeDate(_ date: Date)
    func changeCheck()
}
