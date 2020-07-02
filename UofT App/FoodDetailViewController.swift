//
//  FoodDetailViewController.swift
//  UofT App
//
//  Created by Danny Vo on 2020-07-02.
//  Copyright © 2020 Danny Vo. All rights reserved.
//

import UIKit

class FoodDetailViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    var food: FoodResult!
    var detail = [String]()
    var total = [[String]]()
    var hours = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = food.name
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        
        detail.append("Name: " + food.name)
        detail.append("Description: " + food.description)
        detail.append("Address: " + food.address)
        detail.append("Campus: " + food.campus)
        
        total.append(detail)
        
        let week = [food.hours.sunday, food.hours.monday, food.hours.tuesday, food.hours.wednesday, food.hours.thursday, food.hours.friday, food.hours.saturday]
        
        let days = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
        var dayCounter = 0
        
        for day in week {
            if day.closed == true {
                hours.append("""
                \(days[dayCounter]): CLOSED
                """)
            } else {
                
                var open = 0
                var close = 0
                
                if day.open != nil {
                    open = day.open! / 3600
                }
                
                if day.close != nil {
                    close = day.close! / 3600
                }
                
                if open == 0 && close == 0 {
                    hours.append("""
                    \(days[dayCounter]): OPEN
                    Unavailable hours. Contact for more information.
                    """)
                } else {
                    hours.append("""
                    \(days[dayCounter]): OPEN
                    Open: \(open):00
                    Close: \(close):00
                    """)
                }
            }
            dayCounter += 1
        }
        total.append(hours)
    }
}

extension FoodDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Information"
        } else {
            return "Hours of Operation"
        }
    }
}

extension FoodDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return total[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return total.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "food", for: indexPath)
        
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = total[indexPath.section][indexPath.row]
        return cell
    }
}
