//
//  ViewController.swift
//  UofT App
//
//  Created by Danny Vo on 2020-06-26.
//  Copyright © 2020 Danny Vo. All rights reserved.
//

import UIKit

class CourseViewController: UIViewController, UISearchBarDelegate {
    @IBOutlet var tableView: UITableView!
    var courses = [CourseResult]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search Course ID"
        searchBar.sizeToFit()
        searchBar.delegate = self
        navigationItem.titleView = searchBar
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.showsCancelButton = false
        searchBar.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let courseCode = searchBar.text else { return }
        
        let url = "https://nikel.ml/api/courses?id=" + courseCode //+ "&limit=1"
        getData(from: url)
    }
    
    
    func getData(from url: String) {
        let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { data, response, error in
            guard let data = data, error == nil else {
                print("Something went wrong.")
                return
            }
            var result: Response?
            do {
                result = try JSONDecoder().decode(Response.self, from: data)
            } catch {
                //print("failed to convert \(error.localizedDescription)")
                debugPrint(error)
            }
            
            guard let json = result else { return }
            self.courses = json.response
            //print(json.response[0].meeting_sections[0])
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
        task.resume()
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









