//
//  TrainingListComponent.swift
//  AtlasTeam
//
//  Created by Luke Mason on 1/29/22.
//

import SwiftUI

struct TrainingListComponent: View {
    let training: Training
    var body: some View {
        VStack {
            Text("\(training.date, formatter: trainingDateFormatterPreview)")
                .font(.system(size: 16, weight: .ultraLight, design: .rounded))
            Divider()
            HStack {
                VStack(spacing: 5) {
                    Text("Mileage")
                        .font(.system(size: 16, weight: .ultraLight, design: .rounded))
                        .frame(height: 25, alignment: .center)
                    Text("Pace")
                        .font(.system(size: 16, weight: .ultraLight, design: .rounded))
                        .frame(height: 25, alignment: .center)
                    Text("Rating")
                        .font(.system(size: 16, weight: .ultraLight, design: .rounded))
                        .frame(height: 25, alignment: .center)
                    Spacer()
                }
                Divider()
                    .offset(y: -9)
                VStack(spacing: 5) {
                    Text(training.mileageString)
                        .font(.system(size: 16, weight: .semibold, design: .rounded))
                        .frame(height: 25, alignment: .center)
                    Text(training.paceString)
                        .font(.system(size: 16, weight: .semibold, design: .rounded))
                        .frame(height: 25, alignment: .center)
                    Text("\(training.rating)")
                        .font(.system(size: 16, weight: .semibold, design: .rounded))
                        .frame(height: 25, alignment: .center)
                    Spacer()
                }
            }
        }
        .padding(.top, 15)
        .padding(.horizontal, 10)
        .frame(width: 150, height: 150)
        .background(getGradient(training.type))
        .cornerRadius(5)
    }
}
