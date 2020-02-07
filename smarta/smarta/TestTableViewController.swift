//
//  TestTableViewController.swift
//  smarta
//
//  Created by Julian A. Fordyce on 2/5/20.
//  Copyright © 2020 Julian A. Fordyce. All rights reserved.
//

import UIKit

class TestTableViewController: UITableViewController {
    
    let networkController = NetworkController()
    
    var stations: [Station]  = []
    var loadingIndicator = UIActivityIndicatorView()
    @IBOutlet weak var sementedControl: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadingIndicator.center = view.center
        
        networkController.fetchStationLines(with: Line.red.rawValue) { result in
            
            do {
                let stations = try result.get()
                DispatchQueue.main.async {
                    self.loadingIndicator.startAnimating()
                    self.stations = stations
                    print(self.stations)
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
        // #warning Incomplete implementation, return the number of rows
        stations.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StationTableViewCell.reuseIdentifier, for: indexPath) as? StationTableViewCell else { return UITableViewCell() }
        let station = stations[indexPath.row]
        cell.stationNameLabel.text = station.station.name
        cell.arrivalTimeLabel.text = station.schedule.nextArrival
        cell.directionLabel.text = station.station.direction.rawValue
        cell.containerView.layer.cornerRadius = 12
        //
        // Configure the cell...

        return cell
    }
   
    @IBAction func segmentSelected(_ sender: UISegmentedControl) {
        
        let trainLine = sender.selectedSegmentIndex
        var trainLineString: String
        
        switch trainLine {
        case 0:
            trainLineString =  Line.red.rawValue
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
                    self.stations = stations
                    print(self.stations)
                    self.tableView.reloadData()
                    self.loadingIndicator.stopAnimating()

                }
            } catch {
                print(error)
            }
        }
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

}
