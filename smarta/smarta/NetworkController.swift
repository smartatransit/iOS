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
    
    var station: [Station]?
    
    func fetchStationLines(with line: String, completion: @escaping ([Station]?) -> ()) {
        
        debugPrint("Fetching station lines.")
        
        let lineURL = baseURL.appendingPathComponent(line)
        let request = URLRequest(url: lineURL)
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print("Error \(error)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                completion(nil)
                return
            }
            // This is gross and unsafe, wrap this in a do-try-catch block below.
            self.station =  try! JSONDecoder().decode(Stations.self, from: data)
            print(self.station)
            completion(nil)
        }.resume()
    }
}
