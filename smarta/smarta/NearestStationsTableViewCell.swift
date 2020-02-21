//
//  NearestStationsTableViewCell.swift
//  smarta
//
//  Created by Julian A. Fordyce on 2/20/20.
//  Copyright © 2020 Julian A. Fordyce. All rights reserved.
//

import UIKit

class NearestStationsTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "cell"

    @IBOutlet weak var stationNameLabel: UILabel!
    
    @IBOutlet weak var distanceLabel: UILabel!
}
