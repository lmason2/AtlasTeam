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
    let myTeam: Team
    
    var body: some View {
        List {
            CompleteTrainingListHeader()
                .listRowBackground(LinearGradient(gradient: Gradient(colors: [primaryColor.opacity(0.3), secondaryColor.opacity(0.3)]), startPoint: .topLeading, endPoint: .bottomTrailing))
            ForEach(0..<getNumberOfWeeks(training: training, weekStartsOnMonday: weekStartsOnMonday)) { index in
                let minMax = getMinMax(index: index, training: training, weekStartsOnMonday: weekStartsOnMonday)
                let filteredTraining = training.filter { $0.date >= minMax[0] && $0.date <= minMax[1] }
                NavigationLink(destination: SpecificWeekTrainingView(training: filteredTraining.reversed(), minDate: minMax[0], maxDate: minMax[1], primaryColor: primaryColor, secondaryColor: secondaryColor, myTeam: myTeam), label: {
                    WeeklyTrainingListComponent(training: filteredTraining, minDate: minMax[0], maxDate: minMax[1])
                })
            }
            .listRowBackground(LinearGradient(gradient: Gradient(colors: [primaryColor.opacity(0.3), secondaryColor.opacity(0.3)]), startPoint: .topLeading, endPoint: .bottomTrailing))
        }
        .navigationTitle(username)
    }
}
