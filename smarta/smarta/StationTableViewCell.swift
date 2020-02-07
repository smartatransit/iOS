//
//  StationTableViewCell.swift
//  smarta
//
//  Created by Julian A. Fordyce on 2/6/20.
//  Copyright © 2020 Julian A. Fordyce. All rights reserved.
//

import UIKit

class StationTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "cell"
    
    @IBOutlet weak var stationNameLabel: UILabel!
    
    @IBOutlet weak var arrivalTimeLabel: UILabel!
    
    @IBOutlet weak var directionLabel: UILabel!
    

}
