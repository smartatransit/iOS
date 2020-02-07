//
//  ViewController.swift
//  smarta
//
//  Created by Julian A. Fordyce on 1/31/20.
//  Copyright © 2020 Julian A. Fordyce. All rights reserved.
//

import UIKit

class StationsViewController: UIViewController  {
 
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        networkController.station?.count ?? 0
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "stationContentCell", for: indexPath)
//        let station = networkController.station?[indexPath.row]
//        tableViewCell.textLabel?.text = station?.schedule.trainID
//        
//        return tableViewCell
//    }
//    
//
        
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var lineSegmentedControl: UISegmentedControl!
    
    let networkController = NetworkController()

    var stations: [Station] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    
    @IBAction func segmentedSelected(_ sender: UISegmentedControl) {
//        switch sender.selectedSegmentIndex {
//        case 0:
//            networkController.fetchStationLines(with: Line.red.rawValue) {
//                DispatchQueue.main.async {
//                    self.tableView.reloadData()
//                }
//            }
//            
//        case 1:
//            networkController.fetchStationLines(with: Line.blue.rawValue) {
//                DispatchQueue.main.async {
//                    self.tableView.reloadData()
//                }
//            }
//        case 2:
//            networkController.fetchStationLines(with: Line.green.rawValue) {
//                DispatchQueue.main.async {
//                    self.tableView.reloadData()
//                }
//            }
//        case 3:
//            networkController.fetchStationLines(with: Line.gold.rawValue) {
//                DispatchQueue.main.async {
//                    self.tableView.reloadData()
//                }
//            }
//        default:
//            networkController.fetchStationLines(with: "") { 
//                
//            }
//        }
    }
}

