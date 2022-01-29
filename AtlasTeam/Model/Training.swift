//
//  Training.swift
//  AtlasTeam
//
//  Created by Luke Mason on 1/29/22.
//

import Foundation

struct Training {
    let date: Date
    let type: TrainingType
    let mileage: Double
    let minutes: Double?
    let rating: Int
    let info: String
    var mileageString: String {
        let rounded = round(mileage * 100 / 100.00)
        return String(rounded)
    }
    var paceString: String {
        return ""
    }
}

enum TrainingType {
    case easy
    case workout
    case mediumLong
    case long
    case race
}
