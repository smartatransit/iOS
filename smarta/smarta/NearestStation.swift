//
//  NearestStation.swift
//  smarta
//
//  Created by Julian A. Fordyce on 2/20/20.
//  Copyright © 2020 Julian A. Fordyce. All rights reserved.
//

import Foundation

struct StationByLocation: Codable {
    let stations: [NearestStation]
}

struct NearestStation: Codable {
    
    let stationName: String
    let location: String
    let distance: Double
    
    
    enum CodingKeys: String, CodingKey {
        case stationName = "station-name"
        case location
        case distance
    }
    
    
    
    
}
