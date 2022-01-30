//
//  CompeteTrainingDetailView.swift
//  AtlasTeam
//
//  Created by Luke Mason on 1/29/22.
//

import SwiftUI

struct CompleteTrainingDetailView: View {
    let training: [Training]
    let weekStartsOnMonday: Bool
    let username: String
    let primaryColor: Color
    let secondaryColor: Color
    var body: some View {
        List {
            CompleteTrainingListHeader()
                .listRowBackground(LinearGradient(gradient: Gradient(colors: [primaryColor.opacity(0.3), secondaryColor.opacity(0.3)]), startPoint: .topLeading, endPoint: .bottomTrailing))
            ForEach(0..<getNumberOfWeeks(training: training, weekStartsOnMonday: weekStartsOnMonday)) { _ in
                NavigationLink(destination: SpecificWeekTrainingView(training: training, dateString: "", primaryColor: primaryColor, secondaryColor: secondaryColor), label: {
                    WeeklyTrainingListComponent(training: [], minDate: Date(), maxDate: Date())
                })
            }
            .listRowBackground(LinearGradient(gradient: Gradient(colors: [primaryColor.opacity(0.3), secondaryColor.opacity(0.3)]), startPoint: .topLeading, endPoint: .bottomTrailing))
        }
        .navigationTitle(username)
    }
}

struct CompeteTrainingDetailView_Previews: PreviewProvider {
    static let myTraining = [
        Training(date: Date(), type: .easy, mileage: 10.0, minutes: 70, rating: 8, info: "Additional"),
        Training(date: Date(), type: .workout, mileage: 10.0, minutes: 60, rating: 9, info: "Additional"),
        Training(date: Date(), type: .race, mileage: 10.0, minutes: 60, rating: 9, info: "Additional"),
        Training(date: Date(), type: .mediumLong, mileage: 10.0, minutes: 60, rating: 9, info: "Additional"),
        Training(date: Date(), type: .long, mileage: 10.0, minutes: 60, rating: 9, info: "Additional"),
    ]
    static var previews: some View {
        CompleteTrainingDetailView(training: myTraining, weekStartsOnMonday: true, username: "Lukemason11", primaryColor: Color.blue, secondaryColor: Color.red)
    }
}
