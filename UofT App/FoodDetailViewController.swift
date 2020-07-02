//
//  FoodDetailViewController.swift
//  UofT App
//
//  Created by Danny Vo on 2020-07-02.
//  Copyright © 2020 Danny Vo. All rights reserved.
//

import UIKit

class FoodDetailViewController: UIViewController, UITableViewDelegate {
    @IBOutlet var tableView: UITableView!
    var food: FoodResult!
    var detail = [String]()
    
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
    }
}

extension FoodDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detail.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "food", for: indexPath)
        
        cell.textLabel?.numberOfLines = 0
        
        cell.textLabel?.text = detail[indexPath.row]
        return cell
    }
}
