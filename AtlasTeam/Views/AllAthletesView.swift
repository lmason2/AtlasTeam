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
    var body: some View {
        VStack{
            List {
                ListHeaderRowComponent()
                    .listRowBackground(LinearGradient(gradient: Gradient(colors: [primaryColor.opacity(0.3), secondaryColor.opacity(0.3)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                ForEach(0..<athletes.count) {index in
                    NavigationLink(destination: {
                        CompleteTrainingDetailView(training: athletes[index].activitiesUnwrapped, weekStartsOnMonday: weekStartsOnMonday, username: athletes[index].username, primaryColor: primaryColor, secondaryColor: secondaryColor)
                    }, label: {
                        AllAthleteRowComponent(athlete: athletes[index], weekStartsOnMonday: weekStartsOnMonday)
                            .padding(.vertical, 20)
                    })
                }
                .listRowBackground(LinearGradient(gradient: Gradient(colors: [primaryColor.opacity(0.3), secondaryColor.opacity(0.3)]), startPoint: .topLeading, endPoint: .bottomTrailing))
            }
        }
        .navigationTitle("This Week's Mileage")
    }
}

struct AllAthletesView_Previews: PreviewProvider {
    static var athletes: [Athlete] = [Athlete(username: "Username", email: "Test@email.com", activityRecords: [], activitiesUnwrapped: [Training(date: Date(), type: .long, mileage: 18, minutes: 120, rating: 10, info: "Long Run", raceDistance: "", raceTime: "" )]), Athlete(username: "Username", email: "Test@email.com", activityRecords: [], activitiesUnwrapped: [Training(date: Date(), type: .long, mileage: 18, minutes: 120, rating: 10, info: "Long Run", raceDistance: "", raceTime: "" )])]
    static var previews: some View {
        AllAthletesView(athletes: athletes, primaryColor: Color.blue, secondaryColor: Color.red, weekStartsOnMonday: true)
    }
}
