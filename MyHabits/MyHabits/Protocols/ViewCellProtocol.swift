//
//  ViewCellProtocol.swift
//  MyHabits
//
//  Created by Александр Глазков on 15.01.2021.
//

protocol ViewCellProtocol {
    static var reuseId: String { get }

    func layoutUpdate()
    func updateCell(object: Any)
}
