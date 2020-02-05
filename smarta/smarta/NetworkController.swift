//
//  NetworkController.swift
//  smarta
//
//  Created by Julian A. Fordyce on 2/4/20.
//  Copyright © 2020 Julian A. Fordyce. All rights reserved.
//

import Foundation

let baseURL = URL(string: "https://staging.api.smartatransit.com/api/live/schedule/line/")!

class NetworkController {
    
    func fetchStationLines() {
        
        debugPrint("Fetching station lines.")
        
        URLSession.shared.dataTask(with: baseURL)
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
