//
//  SpecificWeekTrainingView.swift
//  AtlasTeam
//
//  Created by Luke Mason on 1/30/22.
//

import SwiftUI

struct SpecificWeekTrainingView: View {
    let training: [Training]
    let dateString: String
    let primaryColor: Color
    let secondaryColor: Color
    var body: some View {
        List {
            CompleteTrainingListHeader()
                .listRowBackground(LinearGradient(gradient: Gradient(colors: [primaryColor.opacity(0.3), secondaryColor.opacity(0.3)]), startPoint: .topLeading, endPoint: .bottomTrailing))
            ForEach(0..<training.count) { index in
                NavigationLink(destination: TrainingDetailView(training: training[index]), label: {
                    DailyTrainingListComponent(training: training[index])
                })
            }
        }
        .navigationTitle(dateString)
    }
}

struct SpecificWeekTrainingView_Previews: PreviewProvider {
    static let training: [Training] = [Training(date: Date(), type: .easy, mileage: 8, minutes: 60, rating: 10, info: "", raceDistance: nil, raceTime: nil)]
    static var previews: some View {
        SpecificWeekTrainingView(training: training, dateString: "", primaryColor: Color.red, secondaryColor: Color.blue)
    }
}
