//
//  DailyTrainingListComponent.swift
//  AtlasTeam
//
//  Created by Luke Mason on 1/30/22.
//

import SwiftUI

struct DailyTrainingListComponent: View {
    let training: Training
    var body: some View {
        HStack {
            Image(systemName: "square.fill")
                .foregroundColor(getTypeColor(training.type))
            Text("\(training.date, formatter: trainingDateFormatterPreview)")
                .font(.system(size: 14, weight: .semibold, design: .rounded))
            Spacer()
            Divider()
            HStack {
                HStack {
                    Spacer()
                    Text(training.mileageString)
                        .frame(width: 65, alignment: .center)
                        .font(.system(size: 14, weight: .semibold, design: .rounded))
                    Spacer()
                }
                Divider()
                HStack {
                    Spacer()
                    Text("\(training.rating)")
                        .frame(width: 65, alignment: .center)
                        .font(.system(size: 14, weight: .semibold, design: .rounded))
                    Spacer()
                }
            }
            .frame(width: 150)
        }
    }
}
