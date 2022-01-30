//
//  WeeklyTrainingListComponent.swift
//  AtlasTeam
//
//  Created by Luke Mason on 1/30/22.
//

import SwiftUI

struct WeeklyTrainingListComponent: View {
    let training: [Training]
    let minDate: Date
    let maxDate: Date
    
    func getMileageByWeek(minDate: Date, maxDate: Date) -> Double {
        return 10.0
    }
    
    func getRatingByWeek(minDate: Date, maxDate: Date) -> Double {
        return 8.5
    }
    
    var body: some View {
        HStack {
            Text("\(minDate, formatter: completeTrainingDateFormatter) - \(maxDate, formatter: completeTrainingDateFormatter)")
                .font(.system(size: 14, weight: .semibold, design: .rounded))
            Spacer()
            Divider()
            HStack {
                HStack {
                    Spacer()
                    Text("\(getMileageByWeek(minDate: minDate, maxDate: maxDate), specifier: "%.2f")")
                        .frame(width: 65, alignment: .center)
                        .font(.system(size: 14, weight: .semibold, design: .rounded))
                    Spacer()
                }
                Divider()
                HStack {
                    Spacer()
                    Text("\(getRatingByWeek(minDate: minDate, maxDate: maxDate), specifier:" %.2f")")
                        .frame(width: 65, alignment: .center)
                        .font(.system(size: 14, weight: .semibold, design: .rounded))
                    Spacer()
                }
            }
            .frame(width: 150)
        }
    }
}

struct WeeklyTrainingListComponent_Previews: PreviewProvider {
    static var minDate: Date = Date()
    static var maxDate: Date = Date()
    static var training: [Training] = [Training(date: Date(), type: .easy, mileage: 10, minutes: nil, rating: 10, info: "", raceDistance: "", raceTime: "")]
    static var previews: some View {
        WeeklyTrainingListComponent(training: training, minDate: Date(), maxDate: Date())
    }
}
