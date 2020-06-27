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
    var detail = [String]() // array containing all the information for courses
    var total = [[String]]() // array containing both the DETAIL and the DATE/ Time
    
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
        total.append(detail)
        
        var index = 0
        while index < course.meeting_sections.count {
            var courseDate = [String]()
            courseDate.append("Section: " + course.meeting_sections[index].code.uppercased())
            if !(course.meeting_sections[index].times.isEmpty) {
                if (course.meeting_sections[index].times[0].day != nil) {
                    courseDate.append("Day: " + course.meeting_sections[index].times[0].day!.capitalized)
                } else {
                    courseDate.append("Day: Not available")
                }
                
                let start = course.meeting_sections[index].times[0].start! / 3600
                if start == 0 {
                    courseDate.append("Start: Not Available")
                } else {
                    courseDate.append("Start: " + String(start) + ":00")
                }
                
                let end = course.meeting_sections[index].times[0].end! / 3600
                if end == 0 {
                    courseDate.append("End: Not Available")
                } else {
                    courseDate.append("End: " + String(end) + ":00")
                }
                
                let duration = course.meeting_sections[index].times[0].duration! / 3600
                if duration == 0 {
                    courseDate.append("Duration: Not Available")
                } else {
                    courseDate.append("Duration: " + String(duration) + ":00")
                }
                
                if (course.meeting_sections[index].times[0].location != nil){
                    courseDate.append("Location: " + course.meeting_sections[index].times[0].location!)
                } else {
                    courseDate.append("Location: Not available")
                }
            }
            
            if (course.meeting_sections[index].size != 0){
                courseDate.append("Class size: " + String(course.meeting_sections[index].size!))
            } else {
                courseDate.append("Class size: Not available")
            }
            
            courseDate.append("Delivery Type: " + course.meeting_sections[index].delivery)
            
            index += 1
            total.append(courseDate)
        }
    }
}

extension CourseDetailController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Class Description"
        } else {
            return "Lecture/ Tutorial Information \(section)"
        }
    }
}

extension CourseDetailController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return total[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return total.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "courseCell", for: indexPath)
        
        // allows the text to wrap around to the next line rather than trailing dots
        cell.textLabel?.numberOfLines = 0
        
        // have a total array, with subarrays to separate for sections
        cell.textLabel?.text = total[indexPath.section][indexPath.row]
        return cell
    }
}
