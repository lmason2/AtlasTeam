//
//  RaceListComponent.swift
//  AtlasTeam
//
//  Created by Luke Mason on 1/29/22.
//

import SwiftUI

struct RaceListComponent: View {
    let race: Race
    let secondaryColor: Color
    var body: some View {
        VStack {
            Text(race.name)
                .font(.system(size: 16, weight: .ultraLight, design: .rounded))
                .multilineTextAlignment(.leading)
                .frame(height: 30)
            Divider()
            Text("\(race.date, formatter: raceDateFormatter)")
                .font(.system(size: 16, weight: .ultraLight, design: .rounded))
                .multilineTextAlignment(.leading)
                .frame(height: 30)
            Divider()
            Text(race.location)
                .font(.system(size: 16, weight: .ultraLight, design: .rounded))
                .multilineTextAlignment(.leading)
                .frame(height: 30)
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 5)
        .frame(width: 150, height: 150)
        .background(
            LinearGradient(gradient: Gradient(colors: [secondaryColor.opacity(0.2), secondaryColor.opacity(0.5)]), startPoint: .topLeading, endPoint: .bottomTrailing)
        )
        .cornerRadius(5)
    }
}

struct RaceListComponent_Previews: PreviewProvider {
    static var previews: some View {
        RaceListComponent(race: Race(date: Date(), name: "", location: "", additionalInfo: ""), secondaryColor: Color("Blue"))
    }
}
