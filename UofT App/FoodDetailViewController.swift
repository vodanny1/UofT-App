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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = food.name
        navigationController?.navigationBar.prefersLargeTitles = true
    }

}
