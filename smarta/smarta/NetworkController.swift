//
//  NetworkController.swift
//  smarta
//
//  Created by Julian A. Fordyce on 2/4/20.
//  Copyright © 2020 Julian A. Fordyce. All rights reserved.
//

import Foundation
import CoreLocation

let lineBaseURL = URL(string: "https://staging.api.smartatransit.com/api/live/schedule/line/")!
let locationBaseURL = URL(string: "http://staging.api.smartatransit.com/api/static/stations/location")!

class NetworkController {
    
    var station: [Station] = []
    
    func fetchStationLines(with line: String, completion: @escaping (Result<[Station], Error>) -> Void) {
                
        let lineURL = lineBaseURL.appendingPathComponent(line)
        let request = URLRequest(url: lineURL)
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(error!))
                return
            }

            do {
                self.station =  try JSONDecoder().decode(Stations.self, from: data)
                completion(.success(self.station))
                debugPrint("JSON successfully decoded: \(self.station)")
            } catch {
                completion(.failure(error))
                debugPrint("Error decoding JSON: \(error) ")
                return
            }
        }.resume()
    }
    
    func fetchClosestStations(with latitude: Double, and location: Double, completion: @escaping (Result<[Station], Error>) -> Void) {
        <#function body#>
    }
}
