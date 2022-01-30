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
    for i in (0..<training.count) {
        print(training[i].date)
    }
    return 7
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
