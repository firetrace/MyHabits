//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by Александр Глазков on 18.12.2020.
//

import UIKit

class HabitsViewController: UIViewController {

    private let headerTitleItem = UIBarButtonItem(customView: HabitsView(type: .Title))
    private let headerButtonItem = UIBarButtonItem(customView: HabitsView(type: .Button))
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
                
        tabBarController?.navigationItem.leftBarButtonItem = headerTitleItem
        tabBarController?.navigationItem.rightBarButtonItem = headerButtonItem
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        tabBarController?.navigationItem.rightBarButtonItem = nil
        tabBarController?.navigationItem.leftBarButtonItem = nil
    }
}
