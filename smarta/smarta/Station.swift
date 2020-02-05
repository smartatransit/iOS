//
//  Station.swift
//  smarta
//
//  Created by Julian A. Fordyce on 2/4/20.
//  Copyright © 2020 Julian A. Fordyce. All rights reserved.
//

import Foundation

// MARK: - Station
struct Station: Codable {
    let station: StationClass
    let schedule: Schedule
}

// MARK: - Schedule
struct Schedule: Codable {
    let trainID: String
    let nextStation: String
    let destination: Destination
    let nextArrival: String
    let waitingSeconds: String
    let waitingTime: String
    let eventTime: String

    enum CodingKeys: String, CodingKey {
        case trainID = "train-id"
        case nextStation = "next-station"
        case destination
        case nextArrival = "next-arrival"
        case waitingSeconds = "waiting-seconds"
        case waitingTime = "waiting-time"
        case eventTime = "event-time"
    }
}

enum Destination: String, Codable {
    case airportStation = "Airport Station"
    case northSpringsStation = "North Springs Station"
}

// MARK: - StationClass
struct StationClass: Codable {
    let name: String
    let line: Line
    let direction: Direction
}

enum Direction: String, Codable {
    case north = "N"
    case east = "E"
    case south = "S"
    case west = "W"
}

enum Line: String, Codable {
    case red = "Red"
    case blue = "Blue"
    case green = "Green"
    case gold = "Gold"
}
