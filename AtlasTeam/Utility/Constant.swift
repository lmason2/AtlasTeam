//
//  Constant.swift
//  AtlasTeam
//
//  Created by Luke Mason on 1/29/22.
//

import Foundation
import SwiftUI
import CloudKit

let trainingDateFormatterPreview: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "EEEEE M/d"
    return formatter
}()

let trainingDetailDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "EEEE\nMMMM dd, yyyy"
    return formatter
}()

let practiceDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .short
    return formatter
}()

let completeTrainingDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "MM/dd/yy"
    return formatter
}()

let raceDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .none
    return formatter
}()

func getGradient(_ type: TrainingType) -> LinearGradient {
    switch type {
    case .easy:
        return LinearGradient(gradient: Gradient(colors: [Color.teal.opacity(0.2), Color.teal.opacity(0.6)]), startPoint: .topLeading, endPoint: .bottomTrailing)
    case .workout:
        return LinearGradient(gradient: Gradient(colors: [Color.red.opacity(0.2), Color.red.opacity(0.6)]), startPoint: .topLeading, endPoint: .bottomTrailing)
    case .mediumLong:
        return LinearGradient(gradient: Gradient(colors: [Color.mint.opacity(0.2), Color.mint.opacity(0.6)]), startPoint: .topLeading, endPoint: .bottomTrailing)
    case .long:
        return LinearGradient(gradient: Gradient(colors: [Color.purple.opacity(0.2), Color.purple.opacity(0.6)]), startPoint: .topLeading, endPoint: .bottomTrailing)
    case .race:
        return LinearGradient(gradient: Gradient(colors: [Color.yellow.opacity(0.2), Color.yellow.opacity(0.6)]), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
}

func getTrainingTypeString(_ type: TrainingType) -> String {
    switch type {
    case .easy:
        return "Easy"
    case .workout:
        return "Workout"
    case .mediumLong:
        return "Medium Long Run"
    case .long:
        return "Long Run"
    case .race:
        return "Race"
    }
}

func getNumberOfWeeks(training: [Training], weekStartsOnMonday: Bool) -> Int {
    if training.count == 0 {
        return 0
    }
    var myTraining = training.map {$0}
    myTraining.sort(){$0.date > $1.date}
    var mostRecentStartToWeek: Date = Date()
    let newestDate = myTraining[0].date
    for i in 0..<7 {
        let dateToCheck = Calendar.current.date(byAdding: .day, value: -i, to: newestDate)!
        if Calendar.current.dateComponents([.weekday], from: dateToCheck).weekday == (weekStartsOnMonday ? 2 : 1) {
            mostRecentStartToWeek = dateToCheck
            break
        }
    }
    let oldestDate = myTraining[myTraining.count - 1].date
    let numberOfDays = Calendar.current.dateComponents([.day], from: oldestDate, to: mostRecentStartToWeek)
    let numberOfWeeks = Double(numberOfDays.day!) / 7.00
    let roundedWeeks = Int(ceil(numberOfWeeks))
    if mostRecentStartToWeek == oldestDate {
        return 1
    }
    if mostRecentStartToWeek != newestDate {
        return roundedWeeks + 1
    }
    else {
        return roundedWeeks
    }
}

func getTrainingTypeFromString(_ typeString: String) -> TrainingType {
    switch typeString {
        case "Easy":
            return .easy
        case "Workout":
            return .workout
        case "Medium Long Run":
            return .mediumLong
        case "Long Run":
            return .long
        case "Race":
            return .race
        default:
            return .easy
    }
}

func getMinMax(index: Int, training: [Training], weekStartsOnMonday: Bool) -> [Date] {
    var myTraining = training.map {$0}
    myTraining.sort(){$0.date > $1.date}
    var mostRecentStartToWeek: Date = Date()
    let newestDate = myTraining[0].date
    for i in 0..<7 {
        let dateToCheck = Calendar.current.date(byAdding: .day, value: -i, to: newestDate)!
        if Calendar.current.dateComponents([.weekday], from: dateToCheck).weekday == (weekStartsOnMonday ? 2 : 1) {
            mostRecentStartToWeek = dateToCheck
            break
        }
    }
    let minDate = Calendar.current.date(byAdding: .day, value: -index*7, to: mostRecentStartToWeek)!
    let maxDate = Calendar.current.date(byAdding: .day, value: 6, to: minDate)!
    let minDateNoTime = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: minDate)!
    let maxDateNoTime = Calendar.current.date(bySettingHour: 23, minute: 59, second: 59, of: maxDate)!
    return [minDateNoTime, maxDateNoTime]
}

func getMinMaxThisWeek(weekStartsOnMonday: Bool) -> [Date] {
    var mostRecentStartToWeek: Date = Date()
    let newestDate = Date()
    for i in 0..<7 {
        let dateToCheck = Calendar.current.date(byAdding: .day, value: -i, to: newestDate)!
        if Calendar.current.dateComponents([.weekday], from: dateToCheck).weekday == (weekStartsOnMonday ? 2 : 1) {
            mostRecentStartToWeek = dateToCheck
            break
        }
    }
    let maxDate = Calendar.current.date(byAdding: .day, value: 6, to: mostRecentStartToWeek)!
    let minDateNoTime = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: mostRecentStartToWeek)!
    let maxDateNoTime = Calendar.current.date(bySettingHour: 23, minute: 59, second: 59, of: maxDate)!
    print(minDateNoTime)
    print(maxDateNoTime)
    return [minDateNoTime, maxDateNoTime]
}

func getStats(_ filteredTraining: [Training]) -> [Double] {
    var sum = 0.00
    var ratingAvg = 0.00
    for i in 0..<filteredTraining.count {
        sum += filteredTraining[i].mileage
        ratingAvg += Double(filteredTraining[i].rating)
    }
    return [sum, ratingAvg/Double(filteredTraining.count)]
}


func getTypeColor(_ type: TrainingType) -> Color {
    switch type {
    case .easy:
        return Color.teal
    case .workout:
        return Color.red
    case .mediumLong:
        return Color.mint
    case .long:
        return Color.purple
    case .race:
        return Color.yellow
    }
}

let feedback = UINotificationFeedbackGenerator()
