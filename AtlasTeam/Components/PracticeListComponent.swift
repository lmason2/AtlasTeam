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
        HStack(alignment: .center) {
            VStack {
                Spacer()
                Text("\(practice.timestamp, formatter: practiceDateFormatter)")
                    .font(.system(size: 16, weight: .ultraLight, design: .rounded))
                    .multilineTextAlignment(.center)
                    .frame(height: 70)
                
                Divider()
                    .padding(0)
                
                Text(practice.location)
                    .font(.system(size: 16, weight: .ultraLight, design: .rounded))
                    .multilineTextAlignment(.center)
                    .frame(height: 70)
                Spacer()
            }
            .frame(width: 100)
            Divider()
            VStack {
                Spacer()
                Text(practice.additionalInfo)
                    .font(.system(size: 16, weight: .ultraLight, design: .rounded))
                    .multilineTextAlignment(.center)
                    .frame(height: 150)
                Spacer()
            }
            .frame(width: 130, height: 130)
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 5)
        .frame(width: 250, height: 150)
        .background(
            LinearGradient(gradient: Gradient(colors: [secondaryColor.opacity(0.2), secondaryColor.opacity(0.5)]), startPoint: .topLeading, endPoint: .bottomTrailing)
        )
        .cornerRadius(5)
    }
}
