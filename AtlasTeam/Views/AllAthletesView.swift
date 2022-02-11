//
//  AllAthletesView.swift
//  AtlasTeam
//
//  Created by Luke Mason on 1/30/22.
//

import SwiftUI

struct AllAthletesView: View {
    let athletes: [Athlete]
    let primaryColor: Color
    let secondaryColor: Color
    let weekStartsOnMonday: Bool
    let myTeam: Team
    var body: some View {
        VStack{
            List {
                ListHeaderRowComponent()
                    .listRowBackground(LinearGradient(gradient: Gradient(colors: [primaryColor.opacity(0.3), secondaryColor.opacity(0.3)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                ForEach(0..<athletes.count) {index in
                    let minMax = getMinMaxThisWeek(weekStartsOnMonday: weekStartsOnMonday)
                    let filteredTraining = athletes[index].activitiesUnwrapped.filter { $0.date >= minMax[0] }
                    NavigationLink(destination: {
                        CompleteTrainingDetailView(training: athletes[index].activitiesUnwrapped, weekStartsOnMonday: weekStartsOnMonday, username: athletes[index].username, primaryColor: primaryColor, secondaryColor: secondaryColor, myTeam: myTeam)
                    }, label: {
                        AllAthleteRowComponent(athlete: athletes[index], weekStartsOnMonday: weekStartsOnMonday, stats: getStats(filteredTraining))
                            .padding(.vertical, 20)
                    })
                }
                .listRowBackground(LinearGradient(gradient: Gradient(colors: [primaryColor.opacity(0.3), secondaryColor.opacity(0.3)]), startPoint: .topLeading, endPoint: .bottomTrailing))
            }
        }
        .navigationTitle("This Week's Mileage")
    }
}
