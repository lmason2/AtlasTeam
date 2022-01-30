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
    var raceDistance: String?
    var raceTime: String?
    var mileageString: String {
        let rounded = round(mileage * 100) / 100.0
        return String(rounded)
    }
    var minutesString: String {
        if minutes != nil {
            return String(Int(minutes!))
        }
        return "N/A"
    }
    var paceString: String {
        if minutes == nil {
            return "N/A"
        }
        else {
            let minutesPerMileDecimal = minutes! / mileage
            let minutesPerMile = Int(minutesPerMileDecimal)
            let decimal = minutesPerMileDecimal - Double(minutesPerMile)
            let seconds = Int(decimal * 60)
            var secondsString = String(seconds)
            if seconds < 10 {
                secondsString = "0" + secondsString
            }
            return String(minutesPerMile) + ":" + secondsString
        }
    }
}

enum TrainingType {
    case easy
    case workout
    case mediumLong
    case long
    case race
}
