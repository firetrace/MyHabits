//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Александр Глазков on 14.01.2021.
//

import UIKit

class HabitViewController: UIViewController {

    private lazy var navigationBar: UINavigationBar = {
        let navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 54))
        let navigationItem = UINavigationItem(title: "Создать")
                
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
        guard let name = habitView.data.name, let date = habitView.data.date, let color = habitView.data.color else {
            return
        }
        
        HabitsStore.shared.habits.append(Habit(name: name, date: date, color: color))
        cancel()
    }
    
    @objc private func cancel() {
        dismiss(animated: true, completion: nil)
    }
}

extension HabitViewController: HabitProtocol {

    func changeColor(_ color: UIColor) {
        let picker = UIColorPickerViewController()
        picker.selectedColor = color
        picker.delegate = self
        
        self.present(picker, animated: true, completion: nil)
    }
    
    func changeDate(_ date: Date) { }
}

extension HabitViewController: UIColorPickerViewControllerDelegate {
    
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        habitView.data.updateColor(viewController.selectedColor)
    }
}
