//
//  FoodViewController.swift
//  UofT App
//
//  Created by Danny Vo on 2020-06-27.
//  Copyright © 2020 Danny Vo. All rights reserved.
//

import UIKit

class FoodViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    
    var foods = [FoodResult]()
    var total = [[FoodResult]]()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Foods"
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        definesPresentationContext = true
        searchController.searchBar.placeholder = "Search Food"
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
            var result: FoodResponse?
            do {
                result = try JSONDecoder().decode(FoodResponse.self, from: data)
            } catch {
                debugPrint(error)
            }
            
            guard let json = result else { return }
            self.foods = json.response
            
            var toronto = [FoodResult]()
            var mississauga = [FoodResult]()
            var scarborough = [FoodResult]()
            
            
            for food in self.foods {
                if food.campus == "St. George" {
                    toronto.append(food)
                } else if food.campus == "Mississauga" {
                    mississauga.append(food)
                } else if food.campus == "Scarborough" {
                    scarborough.append(food)
                }
            }
            
            self.total.removeAll()
            self.total.append(toronto)
            self.total.append(mississauga)
            self.total.append(scarborough)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
        task.resume()
    }
}

extension FoodViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        
        if searchBar.text!.count > 0 {
            let url = "https://nikel.ml/api/food?tags=" + searchBar.text!
            getData(from: url)
        }
    }
}

extension FoodViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //select new vc
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Toronto"
        }
        
        if section == 1 {
            return "Mississauga"
        }
        
        if section == 2 {
            return "Scarborough"
        }
        return ""
    }
}

extension FoodViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return total[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return total.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "foodCell", for: indexPath)
        cell.textLabel?.text = total[indexPath.section][indexPath.row].name
        return cell
    }
}
