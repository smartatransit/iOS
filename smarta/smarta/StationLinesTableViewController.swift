//
//  TestTableViewController.swift
//  smarta
//
//  Created by Julian A. Fordyce on 2/5/20.
//  Copyright © 2020 Julian A. Fordyce. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class StationLinesTableViewController: UITableViewController, UISearchBarDelegate, CLLocationManagerDelegate {
    
    let networkController = NetworkController()
    let locationManager = CLLocationManager()
    
    var stations: [Station]  = []
    var displayedStations: [Station]  = []
    private let tableViewRefreshControl = UIRefreshControl()
    var loadingIndicator = UIActivityIndicatorView(style: .medium)
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateLocationManager()
        tableView.addSubview(tableViewRefreshControl)
        self.view.addSubview(loadingIndicator)
//        tableViewRefreshControl.addTarget(self, action: <#T##Selector#>, for: .valueChanged)
        loadingIndicator.center = view.center
        searchBar.delegate = self
        networkController.fetchStationLines(with: Line.red.rawValue) { result in
            
            do {
                let stations = try result.get()
                DispatchQueue.main.async {
                    self.loadingIndicator.startAnimating()
                    self.view.addSubview(self.loadingIndicator)
                    self.loadingIndicator.hidesWhenStopped = true
                    self.stations = stations
                    self.displayedStations = stations
                    self.tableView.reloadData()
                    self.loadingIndicator.stopAnimating()
                }
            } catch {
                print(error)
            }
        }
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        displayedStations.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StationTableViewCell.reuseIdentifier, for: indexPath) as? StationTableViewCell else { return UITableViewCell() }
        let station = displayedStations[indexPath.row]
        cell.selectionStyle = .none
        cell.stationNameLabel.text = station.station.name
        cell.arrivalTimeLabel.text = "Arrival time: \(station.schedule.nextArrival)"
        cell.directionLabel.text = "Direction: \(station.station.direction.rawValue)"
        cell.containerView.layer.cornerRadius = 12
        //
        // Configure the cell...

//        if segmentedControl.selectedSegmentIndex == 0 {
//            cell.containerView.backgroundColor = .red
//        } else {
//            cell.containerView.backgroundColor = .cyan
//        }
        
        return cell
    }
   
    @IBAction func segmentSelected(_ sender: UISegmentedControl) {
        
        let trainLine = sender.selectedSegmentIndex
        var trainLineString: String
        
        switch trainLine {
        case 0:
            trainLineString = Line.red.rawValue
        case 1:
            trainLineString = Line.blue.rawValue
        case 2:
            trainLineString = Line.green.rawValue
        case 3:
            trainLineString = Line.gold.rawValue
        default:
            trainLineString = Line.red.rawValue
        }
        
        networkController.fetchStationLines(with: trainLineString) { result in
            
            do {
                let stations = try result.get()
                DispatchQueue.main.async {
                    self.loadingIndicator.startAnimating()
                    self.view.addSubview(self.loadingIndicator)
                    self.loadingIndicator.hidesWhenStopped = true
                    self.stations = stations
                    self.displayedStations = stations
                    print(self.stations)
                    self.tableView.reloadData()
                    self.loadingIndicator.stopAnimating()
                    
                }
            } catch {
                print(error)
            }
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            displayedStations = stations
        } else {
            displayedStations = stations.filter({ (station) -> Bool in
                let tmp: NSString = station.station.name as NSString
                let range = tmp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
                return range.location != NSNotFound
            })
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    @objc private func refreshStationLines() {
       
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
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let cell = stations[indexPath.row]
//        
//    }

}
