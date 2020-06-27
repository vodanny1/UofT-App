//
//  CourseDetailController.swift
//  UofT App
//
//  Created by Danny Vo on 2020-06-26.
//  Copyright © 2020 Danny Vo. All rights reserved.
//

import UIKit

class CourseDetailController: UIViewController {
    @IBOutlet var tableView: UITableView!
    var course: CourseResult!
    var detail = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = course.code
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        
        detail.append("Name: " + course.name)
        detail.append("Description: " + course.description)
        detail.append("Division: " + course.division)
        
        if (course.prerequisites != nil) {
            detail.append("Prerequisite: " + course.prerequisites!)
        } else {
            detail.append("Prerequisite: None")
        }
        
        if (course.corequisites != nil) {
            detail.append("Corequisite: " + course.corequisites!)
        } else {
            detail.append("Corequisite: None")
        }
        
        if (course.exclusions != nil){
            detail.append("Exclusions: " + course.exclusions!)
        } else {
            detail.append("Exclusions: None")
        }
        
        if (course.recommended_preparation != nil){
            detail.append("Recommended Prep: " + course.recommended_preparation!)
        } else {
            detail.append("Recommended Prep: None")
        }
        
        detail.append("Level: " + course.level!)
        detail.append("Campus: " + course.campus)
        detail.append("Term: " + course.term)
        
        detail.append("------------------------------")
        
        var index = 0
        while index < course.meeting_sections.count {
            detail.append("Section: " + course.meeting_sections[index].code)
            
            if (course.meeting_sections[index].times[0].day != nil){
                detail.append("Day: " + course.meeting_sections[index].times[0].day!.capitalized)
            } else {
                detail.append("Day: Not available")
            }
            
            
            let start = course.meeting_sections[index].times[0].start! / 3600
            if start == 0 {
                detail.append("Start: Not Available")
            } else {
                detail.append("Start: " + String(start) + ":00")
            }
            
            let end = course.meeting_sections[index].times[0].end! / 3600
            if end == 0 {
                detail.append("End: Not Available")
            } else {
                detail.append("End: " + String(end) + ":00")
            }
            
            let duration = course.meeting_sections[index].times[0].duration! / 3600
            if duration == 0 {
                detail.append("Duration: Not Available")
            } else {
                detail.append("Duration: " + String(duration) + ":00")
            }
            
            if (course.meeting_sections[index].times[0].location != nil){
                detail.append("Location: " + course.meeting_sections[index].times[0].location!)
            } else {
                detail.append("Location: Not available")
            }
            
            if (course.meeting_sections[index].size != 0){
                detail.append("Class size: " + String(course.meeting_sections[index].size!))
            } else {
                detail.append("Class size: Not available")
            }
            
            detail.append("Delivery Type: " + course.meeting_sections[index].delivery)
            
            detail.append("------------------------------")
            index += 1
        }
    }
    

}

extension CourseDetailController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    }
}

extension CourseDetailController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detail.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "courseCell", for: indexPath)
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = detail[indexPath.row]
        return cell
    }
}
