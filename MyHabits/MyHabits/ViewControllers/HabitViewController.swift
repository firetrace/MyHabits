//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Александр Глазков on 14.01.2021.
//

import UIKit

class HabitViewController: UIViewController {
    
    weak var thisDelegate: HabitProtocol?

    private var dataIndex: Int?
    private var isEditMode: Bool = false
    
    private lazy var navigationBar: UINavigationBar = {
        let navigationBar = UINavigationBar(frame: .zero)

        let navigationItem = UINavigationItem(title: isEditMode ? "Править" : "Создать")
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
    
    convenience init(index: Int?) {
        self.init()
        
        isEditMode = index != nil
        dataIndex = index
        if let thisIndex = dataIndex {
            habitView.setData(data: HabitsStore.shared.habits[thisIndex])
        }
        else {
            habitView.setData(data: nil)
        }
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
        if let data = habitView.getData() {
            if (isEditMode) {
                if let thisDataIndex = dataIndex {
                    HabitsStore.shared.habits[thisDataIndex].name = data.name
                    HabitsStore.shared.habits[thisDataIndex].date = data.date
                    HabitsStore.shared.habits[thisDataIndex].color = data.color
                    HabitsStore.shared.save()
                }
            }
            else {
                HabitsStore.shared.habits.append(Habit(name: data.name, date: data.date, color: data.color))
            }
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
