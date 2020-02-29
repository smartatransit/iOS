//
//  TableViewController.swift
//  smarta
//
//  Created by Julian A. Fordyce on 2/22/20.
//  Copyright © 2020 Julian A. Fordyce. All rights reserved.
//

import UIKit

class StationTableViewController: UIViewController, HasStationSource, UITableViewDataSource, UITableViewDelegate {
    
    let tableView = UITableView()
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
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        
        setupLayout()
        view.backgroundColor = .white
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
    }

    // MARK: - Table view data source
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stations.count
    }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

//        guard let cell = tableView.dequeueReusableCell(withIdentifier: StationDetailTableViewCell.reuseIdentifier, for: indexPath) as? StationDetailTableViewCell else { return UITableViewCell() }
        let station = stations[indexPath.row]
        cell.textLabel?.text = station.schedule.waitingTime
        cell.detailTextLabel?.text = station.schedule.nextArrival
        return cell
    }
    

 

    // MARK: - Navigation
    
    func setupLayout() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        tableView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: 0).isActive = true
    }

}
 
