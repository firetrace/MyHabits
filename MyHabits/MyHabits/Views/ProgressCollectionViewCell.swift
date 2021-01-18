//
//  ProgressCollectionViewCell.swift
//  MyHabits
//
//  Created by Александр Глазков on 15.01.2021.
//

import UIKit

class ProgressCollectionViewCell: UICollectionViewCell {
    
    private lazy var headerLabel: UILabel = {
        var label = UILabel(frame: .zero)
        label.textAlignment = .left
        label.text = progressHeader
        label.font = getFontStyle(style: .Body)
        label.textColor = getColorStyle(style: .Gray)
        label.toAutoLayout()
        
        return label
    }()
    
    private lazy var progressLabel: UILabel = {
        var label = UILabel(frame: .zero)
        label.textAlignment = .right
        label.font = getFontStyle(style: .Body)
        label.textColor = getColorStyle(style: .Gray)
        label.toAutoLayout()
        
        return label
    }()
    
    private lazy var progressBar: UIProgressView = {
        var view = UIProgressView(frame: .zero)
        view.progressTintColor = getColorStyle(style: .Magenta)
        view.layer.cornerRadius = 4
        view.layer.masksToBounds = true
        view.toAutoLayout()
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        layoutUpdate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProgressCollectionViewCell: ViewCellProtocol {
    
    static var reuseId: String { String(describing: self) }
            
    func layoutUpdate() {
        contentView.backgroundColor = .systemBackground
        contentView.layer.cornerRadius = 8
        contentView.clipsToBounds = true
        
        contentView.addSubview(headerLabel)
        contentView.addSubview(progressLabel)
        contentView.addSubview(progressBar)
                
        NSLayoutConstraint.activate([headerLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: topConst10),
                                     headerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: leadingConst12),
                                     headerLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5),
                                     
                                     progressLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: topConst10),
                                     progressLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: topConst10),
                                     progressLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: trailingConst12),
                                     progressLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3),
                                     
                                     progressBar.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: topConst10),
                                     progressBar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: leadingConst12),
                                     progressBar.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: trailingConst12),
                                     progressBar.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: bottomConst15)
        ])
    }
    
    func updateCell(object: Any) {
        if let progress = object as? Float {
            progressBar.progress = progress
            progressLabel.text = String(format: "%.0f %%", progress * 100)
        }
    }
}
