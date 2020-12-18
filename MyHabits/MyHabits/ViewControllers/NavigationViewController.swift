//
//  NavigationViewController.swift
//  MyHabits
//
//  Created by Александр Глазков on 18.12.2020.
//

import UIKit

class NavigationViewController: UINavigationController {
    
    convenience init() {
        self.init(rootViewController: TabBarViewController())
    }
}
