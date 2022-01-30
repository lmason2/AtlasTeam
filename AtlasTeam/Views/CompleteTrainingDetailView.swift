//
//  CompeteTrainingDetailView.swift
//  AtlasTeam
//
//  Created by Luke Mason on 1/29/22.
//

import SwiftUI

struct CompleteTrainingDetailView: View {
    let training: [Training]
    var body: some View {
        List {
            ForEach(0..<getNumberOfWeeks(training)) { _ in
                Text("test")
            }
        }
    }
}

struct CompeteTrainingDetailView_Previews: PreviewProvider {
    static let myTraining = [
        Training(date: Date(), type: .easy, mileage: 10.0, minutes: 70, rating: 8, info: "Additional"),
        Training(date: Date(), type: .workout, mileage: 10.0, minutes: 60, rating: 9, info: "Additional"),
        Training(date: Date(), type: .race, mileage: 10.0, minutes: 60, rating: 9, info: "Additional"),
        Training(date: Date(), type: .mediumLong, mileage: 10.0, minutes: 60, rating: 9, info: "Additional"),
        Training(date: Date(), type: .long, mileage: 10.0, minutes: 60, rating: 9, info: "Additional"),
    ]
    static var previews: some View {
        CompleteTrainingDetailView(training: myTraining)
    }
}
