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
    var stations: [Station]  = []
    var displayedStations: [Station]  = []
    private let tableViewRefreshControl = UIRefreshControl()
    var loadingIndicator = UIActivityIndicatorView(style: .medium)
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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

}
