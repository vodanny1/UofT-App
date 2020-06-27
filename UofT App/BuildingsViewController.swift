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
    var buildings = [BuildingResult]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Buildings"
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        definesPresentationContext = true
        searchController.searchBar.placeholder = "Search Building ID"
        searchController.obscuresBackgroundDuringPresentation = false
        
        navigationItem.searchController = searchController
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.hidesSearchBarWhenScrolling = false
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInsetAdjustmentBehavior = .never
    }
    
    func getData(from url: String) {
        let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { data, response, error in
            guard let data = data, error == nil else {
                print("Something went wrong.")
                return
            }
            var result: BuildingResponse?
            do {
                result = try JSONDecoder().decode(BuildingResponse.self, from: data)
            } catch {
                debugPrint(error)
            }
            
            guard let json = result else { return }
            self.buildings = json.response
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
        task.resume()
    }
}

extension BuildingsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        
        if searchBar.text!.count > 0 {
            let url = "https://nikel.ml/api/buildings?limit=1&code==" + searchBar.text!.uppercased()
            getData(from: url)
        }
    }
}

extension BuildingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "BuildingDetail") as? BuildingDetailController {
            vc.building = buildings[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension BuildingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return buildings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "buildingCell", for: indexPath)
        cell.textLabel?.text = buildings[indexPath.row].code + " | " + buildings[indexPath.row].name
        return cell
    }
}
