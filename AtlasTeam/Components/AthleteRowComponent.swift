//
//  AthleteRowComponent.swift
//  AtlasTeam
//
//  Created by Luke Mason on 1/28/22.
//

import SwiftUI

struct AthleteRowComponent: View {
    let athlete: Athlete
    let primaryColor: Color
    let weekStartsOnMonday: Bool
    let stats: [Double]
    
    var body: some View {
        VStack {
            Text(athlete.username)
                .font(.system(size: 16, weight: .ultraLight, design: .rounded))
            Divider()
            HStack {
                VStack {
                    Text("Mileage")
                        .font(.system(size: 16, weight: .ultraLight, design: .rounded))
                    Text("Avg. Rating")
                        .font(.system(size: 16, weight: .ultraLight, design: .rounded))
                }
                Divider()
                VStack {
                    Text("\(stats[0], specifier: "%.1f")")
                        .font(.system(size: 16, weight: .semibold, design: .rounded))
                    Text("\(stats[1], specifier: "%.1f")")
                        .font(.system(size: 16, weight: .semibold, design: .rounded))
                }
            }
           
            Spacer()
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 5)
        .frame(width: 150, height: 150)
        .background(
            LinearGradient(gradient: Gradient(colors: [primaryColor.opacity(0.2), primaryColor.opacity(0.7)]), startPoint: .topLeading, endPoint: .bottomTrailing)
        )
        .cornerRadius(5)
    }
}
