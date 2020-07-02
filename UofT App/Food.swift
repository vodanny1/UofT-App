//
//  Food.swift
//  UofT App
//
//  Created by Danny Vo on 2020-06-27.
//  Copyright © 2020 Danny Vo. All rights reserved.
//

import Foundation

struct FoodResponse: Codable {
    let response: [FoodResult]
    let status_code: Int
    let status_message: String
}

struct FoodResult: Codable {
    let id: String
    let name: String
    let description: String
    let campus: String
    let address: String
    let hours: Hour
}

struct Hour: Codable {
    let sunday: Operation
    let monday: Operation
    let tuesday: Operation
    let wednesday: Operation
    let thursday: Operation
    let friday: Operation
    let saturday: Operation
}

struct Operation: Codable {
    let closed: Bool?
    let open: Int?
    let close: Int?
}
