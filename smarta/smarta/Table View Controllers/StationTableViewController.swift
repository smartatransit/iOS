//
//  TableViewController.swift
//  smarta
//
//  Created by Julian A. Fordyce on 2/22/20.
//  Copyright © 2020 Julian A. Fordyce. All rights reserved.
//

import UIKit

class StationTableViewController: UITableViewController, HasStationSource {
    
    let networkController = NetworkController()
    var source: String
    var stations: [Station] = []
    
    init(source: String) {
        self.source = source
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        networkController.fetchStationInfo(by: source) { (result) in
            do {
                let stations = try result.get()
                self.stations = stations
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                print("XYZ: \(stations)")
            } catch {
                print(error)
            }
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return stations.count
//    }
//
//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "CELL", for: indexPath)
//
////        guard let cell = tableView.dequeueReusableCell(withIdentifier: StationDetailTableViewCell.reuseIdentifier, for: indexPath) as? StationDetailTableViewCell else { return UITableViewCell() }
//        let station = stations[indexPath.row]
////        cell.waitingTimeLabel.text = station.schedule.waitingTime
////        cell.arrivalTimeLabel.text = station.schedule.nextArrival
////        cell.selectionStyle = .none
////        
//        cell.textLabel?.text = station.schedule.waitingTime
//        cell.detailTextLabel?.text = station.schedule.waitingTime
//        return cell
//    }
    

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
    
    func setupLayout() {
        
    }

}
