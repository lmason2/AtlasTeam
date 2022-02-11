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
    let stats: [Double]
    
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
