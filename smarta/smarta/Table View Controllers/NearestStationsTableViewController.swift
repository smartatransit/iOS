//
//  NearestStationsTableViewController.swift
//  smarta
//
//  Created by Julian A. Fordyce on 2/20/20.
//  Copyright © 2020 Julian A. Fordyce. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class NearestStationsTableViewController: UITableViewController, CLLocationManagerDelegate {
    
    let networkController = NetworkController()
    let locationManager = CLLocationManager()
    
    var stationByLocation: StationByLocation?
    var stations: [Station]  = []

    override func viewDidLoad() {
        super.viewDidLoad()
        updateLocationManager()
    
        networkController.fetchStationInfo(by: "Indian Creek Station") { result in
                do {
                    let stations = try result.get()
                    self.stations = stations
                    print("THE: \(stations)")
                } catch {
                    print(error)
                }
        }
    }


    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stationByLocation?.stations.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NearestStationsTableViewCell.reuseIdentifier, for: indexPath) as? NearestStationsTableViewCell else { return UITableViewCell() }
        
        if let stationByLocation = self.stationByLocation {
            let station = stationByLocation.stations[indexPath.row]
            cell.selectionStyle = .none
            cell.stationNameLabel.text = " \(station.stationName)"
            cell.distanceLabel.text = "\(            shortenNumber(with: station.distance)!) Miles Away"
            cell.containerView.layer.cornerRadius = 12
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let stationName = stationByLocation?.stations[indexPath.row].stationName
        navigationController?.pushViewController(<#T##viewController: UIViewController##UIViewController#>, animated: <#T##Bool#>)
    }
    

    func shortenNumber(with digits: Double) -> String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .none
        let newString = numberFormatter.string(from: NSNumber(value: digits))
        return newString
    }

    func updateLocationManager() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locationValue = manager.location?.coordinate else { return }
        print("Coordinates: \(locationValue.latitude)  \(locationValue.longitude)")
        networkController.fetchClosestStations(with: locationValue.latitude, and: locationValue.longitude) { result in
            
            do {
                let stations = try result.get()
                DispatchQueue.main.async {
                    self.stationByLocation = stations
                    self.tableView.reloadData()
                }
            } catch {
                print(error)
            }
        }
    }


}
