//
//  PracticeListComponent.swift
//  AtlasTeam
//
//  Created by Luke Mason on 1/29/22.
//

import SwiftUI

struct PracticeListComponent: View {
    let practice: Practice
    let secondaryColor: Color
    var body: some View {
        VStack {
            Text("\(practice.timestamp, formatter: practiceDateFormatter)")
                .font(.system(size: 16, weight: .ultraLight, design: .rounded))
                .multilineTextAlignment(.leading)
                .frame(height: 20)
            Divider()
            Text(practice.location)
                .font(.system(size: 16, weight: .ultraLight, design: .rounded))
                .multilineTextAlignment(.leading)
                .frame(height: 30)
            Divider()
            if practice.additionalInfo != "" {
                Text(practice.additionalInfo)
                    .font(.system(size: 16, weight: .ultraLight, design: .rounded))
                    .multilineTextAlignment(.leading)
                    .frame(height: 50)
            }
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
