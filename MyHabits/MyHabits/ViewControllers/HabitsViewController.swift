//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by Александр Глазков on 18.12.2020.
//

import UIKit

class HabitsViewController: UIViewController {

    private lazy var addButton: UIBarButtonItem = {
        var button = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: nil)
        button.tintColor = getColorStyle(style: .Magenta)
            
        return button
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
    }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        tabBarController?.navigationItem.largeTitleDisplayMode = .always
        
        tabBarController?.navigationItem.title = "Сегодня"
        tabBarController?.navigationItem.rightBarButtonItem = addButton
    }

}
