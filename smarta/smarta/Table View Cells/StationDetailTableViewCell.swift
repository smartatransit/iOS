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

    @IBOutlet weak var waitingTimeLabel: UILabel!
    
    @IBOutlet weak var arrivalTimeLabel: UILabel!
    
}
