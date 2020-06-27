//
//  BuildingsViewController.swift
//  UofT App
//
//  Created by Danny Vo on 2020-06-26.
//  Copyright © 2020 Danny Vo. All rights reserved.
//

import UIKit

class BuildingsViewController: UIViewController, UISearchBarDelegate {
    @IBOutlet var tableView: UITableView!
    var buildings = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let searchBar = UISearchBar()
        searchBar.placeholder = "Search Building ID"
        searchBar.sizeToFit()
        searchBar.delegate = self
        navigationItem.titleView = searchBar
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    

}

extension BuildingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if let vc = storyboard?.instantiateViewController(identifier: "CourseDetail") as? CourseDetailController {
//            vc.course = courses[indexPath.row]
//            navigationController?.pushViewController(vc, animated: true)
//        }
    }
}

extension BuildingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return buildings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "buildingCell", for: indexPath)
//        cell.textLabel?.text = courses[indexPath.row].code + " | " + courses[indexPath.row].term + " | " + courses[indexPath.row].campus
        return cell
    }
}
