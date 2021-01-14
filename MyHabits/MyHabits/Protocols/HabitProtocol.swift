//
//  HabitProtocol.swift
//  MyHabits
//
//  Created by Александр Глазков on 14.01.2021.
//

import UIKit

protocol HabitProtocol: AnyObject {
    func changeColor(_ color: UIColor)
    func changeDate(_ date: Date)
}
