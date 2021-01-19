//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Александр Глазков on 14.01.2021.
//

import UIKit

class HabitViewController: UIViewController {
    
    weak var thisDelegate: HabitProtocol?

    private var isEditMode: Bool = false
    
    private lazy var navigationBar: UINavigationBar = {
        let navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 54))
        
        let navigationItem = UINavigationItem(title: isEditMode ? "Править" : "Создать")
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(cancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(save))
        
        navigationBar.setItems([navigationItem], animated: false)
        
        return navigationBar
    }()
    
    private lazy var habitView: HabitView =  {
        var view = HabitView(frame: .zero)
        view.thisDelegate = self
        view.toAutoLayout()
        
        return view;
    }();
    
    convenience init(data: Habit?) {
        self.init()
        
        isEditMode = data != nil
        habitView.setData(data: data)
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground        
        setupLayout()
    }
    
    private func setupLayout() {
        view.addSubview(navigationBar)
        view.addSubview(habitView)
        
        NSLayoutConstraint.activate([habitView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor),
                                     habitView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                                     habitView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                                     habitView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)])
    }

    @objc private func save() {
        if let data = habitView.getData() {
            HabitsStore.shared.habits.append(Habit(name: data.name, date: data.date, color: data.color))
            thisDelegate?.updateData()
            cancel()
        }
    }
    
    @objc private func cancel() {
        dismiss(animated: true, completion: nil)
    }
}

extension HabitViewController: HabitProtocol {
    
    func updateData() {
        thisDelegate?.updateData()
    }
    
    func presentController(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?) {
        self.present(viewControllerToPresent, animated: flag, completion: completion)
    }
    
    func dismissController(animated: Bool, completion: (() -> Void)?) {
        self.dismiss(animated: animated, completion: completion)
        thisDelegate?.dismissController(animated: true, completion: nil)
    }
}
