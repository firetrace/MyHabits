//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Александр Глазков on 14.01.2021.
//

import UIKit

class HabitViewController: UIViewController {
    
    weak var thisDelegate: HabitProtocol?
    
    private var isNew: Bool { get { habitView.data.isNew } }
    
    private lazy var navigationBar: UINavigationBar = {
        let navigationBar = UINavigationBar(frame: .zero)

        let navigationItem = UINavigationItem(title: isNew ? "Править" : "Создать")
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(cancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(save))
        
        navigationBar.setItems([navigationItem], animated: false)
        navigationBar.toAutoLayout()
        
        return navigationBar
    }()
    
    private lazy var habitView: HabitView =  {
        var view = HabitView(frame: .zero)
        view.thisDelegate = self
        view.toAutoLayout()
        
        return view;
    }();
    
    convenience init(data: HabitModel) {
        self.init()
        self.habitView.data = data
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground        
        setupLayout()
    }
    
    private func setupLayout() {
        view.addSubview(navigationBar)
        view.addSubview(habitView)
        
        NSLayoutConstraint.activate([navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                                     navigationBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                                     navigationBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                                     navigationBar.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
                                     navigationBar.heightAnchor.constraint(equalToConstant: 54),
                                     
                                     habitView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor),
                                     habitView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                                     habitView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                                     habitView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)])
    }

    @objc private func save() {
        if (isNew == false) {
            if let habit = habitView.data.getHabit() {

                habit.name = habitView.data.name
                habit.date = habitView.data.date
                habit.color = habitView.data.color
                
                HabitsStore.shared.save()
            }
        } else { HabitsStore.shared.habits.append(Habit(name: habitView.data.name, date: habitView.data.date, color: habitView.data.color)) }
        
        thisDelegate?.updateData()
        cancel()
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
