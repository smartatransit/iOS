//
//  StationDetailTableViewCell.swift
//  smarta
//
//  Created by Julian A. Fordyce on 2/22/20.
//  Copyright © 2020 Julian A. Fordyce. All rights reserved.
//

import UIKit

class StationDetailTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "Cell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    lazy var containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(waitingTimeLabel)
        stackView.addArrangedSubview(arrivalTimeLabel)
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
//        stackView.alignment = .center
        return stackView
    }()

    lazy var arrivalTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var waitingTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setUpViews() {
        contentView.addSubview(containerStackView)
        containerStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        containerStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
        containerStackView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 16).isActive = true
               
        
    }
    
}
