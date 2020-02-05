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
    
    let networkController = NetworkController()

    override func viewDidLoad() {
        super.viewDidLoad()
        networkController.fetchStationLines { (_) in
            
        }
    }


}



extension UIViewController: UITableViewDelegate & UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    }
}
