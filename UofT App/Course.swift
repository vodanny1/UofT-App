//
//  Course.swift
//  UofT App
//
//  Created by Danny Vo on 2020-06-26.
//  Copyright © 2020 Danny Vo. All rights reserved.
//

import Foundation

struct CourseResponse: Codable {
    let response: [CourseResult]
    let status_code: Int
    let status_message: String
}

struct CourseResult: Codable {
    let id: String
    let code: String
    let name: String
    let description: String
    let division: String
    let department: String?
    let prerequisites: String?
    let corequisites: String?
    let exclusions: String?
    let recommended_preparation: String?
    let level: String?
    let campus: String
    let term: String
    let arts_and_science_breadth: String?
    let arts_and_science_dsitribution: String?
    let utm_distribution: String?
    let utsc_breadth: String?
    let apsc_electives: String?
    let meeting_sections: [Section]
}

struct Section: Codable {
    let code: String
    let times: [Time]
    let size: Int? 
    let delivery: String
}

struct Time: Codable {
    let day: String?
    let start: Int?
    let end: Int?
    let duration: Int?
    let location: String?
}
