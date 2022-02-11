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
    
    func getMileage() -> Double {
        var sum = 0.00
        for i in 0..<training.count {
            sum += training[i].mileage
        }
        return sum
    }
    
    func getRating() -> Double {
        var rating = 0.00
        for i in 0..<training.count {
            rating += Double(training[i].rating)
        }
        return rating / Double(training.count)
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
                    Text("\(getMileage(), specifier: "%.2f")")
                        .frame(width: 65, alignment: .center)
                        .font(.system(size: 14, weight: .semibold, design: .rounded))
                    Spacer()
                }
                Divider()
                HStack {
                    Spacer()
                    Text("\(getRating(), specifier:" %.2f")")
                        .frame(width: 65, alignment: .center)
                        .font(.system(size: 14, weight: .semibold, design: .rounded))
                    Spacer()
                }
            }
            .frame(width: 150)
        }
    }
}
