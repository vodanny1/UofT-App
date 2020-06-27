//
//  ViewController.swift
//  UofT App
//
//  Created by Danny Vo on 2020-06-26.
//  Copyright © 2020 Danny Vo. All rights reserved.
//

import UIKit
//UISearchBarDelegate
class CourseViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    var courses = [CourseResult]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Courses"
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        definesPresentationContext = true
        searchController.searchBar.placeholder = "Search Course ID"
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
            var result: CourseResponse?
            do {
                result = try JSONDecoder().decode(CourseResponse.self, from: data)
            } catch {
                debugPrint(error)
            }
            
            guard let json = result else { return }
            self.courses = json.response
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
        task.resume()
    }
}

extension CourseViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        
        if searchBar.text!.count > 0 {
            let url = "https://nikel.ml/api/courses?id=" + searchBar.text! //+ "&limit=1"
            getData(from: url)
        }
    }
}

extension CourseViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "CourseDetail") as? CourseDetailController {
            vc.course = courses[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension CourseViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = courses[indexPath.row].code + " | " + courses[indexPath.row].term + " | " + courses[indexPath.row].campus
        return cell
    }
}









