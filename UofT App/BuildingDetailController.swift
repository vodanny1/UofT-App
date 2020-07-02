//
//  BuildingDetailController.swift
//  UofT App
//
//  Created by Danny Vo on 2020-06-27.
//  Copyright © 2020 Danny Vo. All rights reserved.
//

import UIKit

class BuildingDetailController: UIViewController, UITableViewDelegate {
    @IBOutlet var tableView: UITableView!
    var building: BuildingResult!
    var detail = [String]() // array containing all the information for buildings
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = building.name
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        
        detail.append("Name: " + building.name)
        detail.append("Code: " + building.code)
        detail.append("Short Name: " + building.short_name)
        detail.append("Street: " + building.address.street)
        detail.append("Campus: " + building.address.city)
    }
}

extension BuildingDetailController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detail.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "buildingCell", for: indexPath)
        
        cell.textLabel?.numberOfLines = 0
        
        cell.textLabel?.text = detail[indexPath.row]
        return cell
    }
}


