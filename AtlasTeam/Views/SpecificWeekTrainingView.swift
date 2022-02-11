//
//  SpecificWeekTrainingView.swift
//  AtlasTeam
//
//  Created by Luke Mason on 1/30/22.
//

import SwiftUI

struct SpecificWeekTrainingView: View {
    let training: [Training]
    let minDate: Date
    let maxDate: Date
    let primaryColor: Color
    let secondaryColor: Color
    let myTeam: Team
    @State var myTrainingLoaded: Bool = true
    var body: some View {
        List {
            CompleteTrainingListHeader()
                .listRowBackground(LinearGradient(gradient: Gradient(colors: [primaryColor.opacity(0.3), secondaryColor.opacity(0.3)]), startPoint: .topLeading, endPoint: .bottomTrailing))
            ForEach(0..<training.count) { index in
                NavigationLink(destination: TrainingDetailView(training: training[index], myTeam: myTeam, myTrainingLoaded: $myTrainingLoaded), label: {
                    DailyTrainingListComponent(training: training[index])
                })
            }
        }
        .navigationTitle("\(minDate, formatter: completeTrainingDateFormatter) - \(maxDate, formatter: completeTrainingDateFormatter)")
    }
}
