//
//  HabitDetailsViewController.swift
//  MyHabits
//
//  Created by Admin on 19.01.2021.
//

import UIKit

class HabitDetailsViewController: UIViewController {

    weak var thisDelegate: HabitProtocol?
    
    private var data: HabitModel = HabitModel()
    
    private lazy var editButton: UIBarButtonItem = {
        var button = UIBarButtonItem(title: "Править", style: .plain, target: self, action: #selector(edit))
        button.tintColor = getColorStyle(style: .Magenta)
            
        return button
    }()
    
    private lazy var tableView: UITableView =  {
        var table = UITableView(frame: CGRect.zero, style: .grouped)
        table.dataSource = self
        table.register(HabitTableViewCell.self, forCellReuseIdentifier: HabitTableViewCell.reuseId)
        table.toAutoLayout()
        
        return table
    }();
        
    convenience init(data: HabitModel) {
        self.init()
        self.data = data
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = data.name
        view.backgroundColor = .systemBackground
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = editButton
    }
    
    private func setupLayout() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                                     tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                                     tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                                     tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)])
    }
    
    @objc private func edit() {
        let habitViewController = HabitViewController(data: data)
        habitViewController.thisDelegate = self
        navigationController?.present(habitViewController, animated: true, completion: nil)
    }
}

extension HabitDetailsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? { detailsTableHeader }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { HabitsStore.shared.dates.count }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HabitTableViewCell.reuseId, for: indexPath)
        if let editCell = cell as? CellProtocol, let indexData = data.id {
            let habit = HabitsStore.shared.habits[indexData]
            
            let date = HabitsStore.shared.dates.sorted(by: { $0.compare($1) == .orderedDescending })[indexPath.row]
            let isCheck = HabitsStore.shared.habit(habit, isTrackedIn: date)
            
            editCell.updateCell(object: CellModel(date: date, isCheck: isCheck))
        }
        
        return cell
    }
}

extension HabitDetailsViewController: HabitProtocol {

    func updateData() {
        thisDelegate?.updateData()
    }
    
    func presentController(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?) {
        present(viewControllerToPresent, animated: flag, completion: completion)
    }
    
    func dismissController(animated: Bool, completion: (() -> Void)?) {
        updateData()
        navigationController?.popViewController(animated: true)
    }
}
