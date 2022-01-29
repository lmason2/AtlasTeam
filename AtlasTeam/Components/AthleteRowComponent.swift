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
    
    var body: some View {
        VStack {
            Text(athlete.name)
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
                    Text("\(athlete.mileage)")
                        .font(.system(size: 16, weight: .semibold, design: .rounded))
                    Text("\(4)")
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

struct AthleteRowComponent_Previews: PreviewProvider {
    
    static var previews: some View {
        AthleteRowComponent(athlete: Athlete(name: "Luke Mason", mileage: 80), primaryColor: Color("Blue"))
    }
}
