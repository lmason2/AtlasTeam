//
//  AllAthleteRowComponent.swift
//  AtlasTeam
//
//  Created by Luke Mason on 1/30/22.
//

import SwiftUI

struct AllAthleteRowComponent: View {
    let athlete: Athlete
    let weekStartsOnMonday: Bool
    
    var stats: [Double] {
        var myTraining = athlete.activitiesUnwrapped.map {$0}
        myTraining.sort(){$0.date > $1.date}
        var mostRecentStartToWeek: Date = Date()
        let newestDate = Date()
        for i in 0..<7 {
            let dateToCheck = Calendar.current.date(byAdding: .day, value: -i, to: newestDate)!
            if Calendar.current.dateComponents([.weekday], from: dateToCheck).weekday == (weekStartsOnMonday ? 1 : 7) {
                mostRecentStartToWeek = dateToCheck
                break
            }
        }
        let filteredTraining = myTraining.compactMap({ $0 as Training }).filter { $0.date >= mostRecentStartToWeek }
        if filteredTraining.count == 0 {
            return [0.00, 0.00]
        }
        var sum = 0.00
        var ratingAvg = 0.00
        for i in 0..<filteredTraining.count {
            sum += filteredTraining[i].mileage
            ratingAvg += Double(filteredTraining[i].rating)
        }
        return [sum, ratingAvg/Double(filteredTraining.count)]
    }
    var body: some View {
        HStack {
            Text(athlete.username)
                .font(.system(size: 20, weight: .semibold, design: .rounded))
            Spacer()
            Divider()
            HStack {
                HStack{
                    Spacer()
                    Text("\(stats[0], specifier: "%.2f")")
                        .font(.system(size: 16, weight: .medium, design: .rounded))
                        .frame(width: 65, alignment: .center)
                    Spacer()
                }
                Divider()
                HStack {
                    Spacer()
                    Text("\(stats[1], specifier: "%.2f")")
                        .font(.system(size: 16, weight: .medium, design: .rounded))
                        .frame(width: 65, alignment: .center)
                    Spacer()
                }
            }
            .frame(width: 150)
        }
    }
}

struct AllAthleteRowComponent_Previews: PreviewProvider {
    static var athlete: Athlete = Athlete(username: "Username", email: "email", activityRecords: [], activitiesUnwrapped: [Training(date: Date(), type: .long, mileage: 18, minutes: nil, rating: 10, info: "Long run", raceDistance: nil, raceTime: nil)])
    static var previews: some View {
        AllAthleteRowComponent(athlete: athlete, weekStartsOnMonday: true)
            .previewLayout(.sizeThatFits)
    }
}
