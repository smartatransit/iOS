//
//  ViewController.swift
//  smarta
//
//  Created by Julian A. Fordyce on 1/31/20.
//  Copyright © 2020 Julian A. Fordyce. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var lineSegmentedControl: UISegmentedControl!
    
    let networkController = NetworkController()

    override func viewDidLoad() {
        super.viewDidLoad()
        networkController.fetchStationLines(with: "Red") { (_) in
            
        }
    }

    
    @IBAction func segmentedSelected(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
            case 0:
                networkController.fetchStationLines(with: "Red") { (_) in
                    
            }
            
            case 1:
                networkController.fetchStationLines(with: "Blue") { (_) in
                                   
                           }
        case 2:
            networkController.fetchStationLines(with: "Green") { (_) in
                               
                       }
        case 3:
            networkController.fetchStationLines(with: "Gold") { (_) in
                               
                       }
        default:
            networkController.fetchStationLines(with: "") { (_) in
                               
                       }
        }
        if sender.selectedSegmentIndex == 0 {
            
        }
    }
    

}



extension UIViewController: UITableViewDelegate & UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
