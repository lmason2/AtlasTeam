//
//  AnnouncementListComponent.swift
//  AtlasTeam
//
//  Created by Luke Mason on 1/29/22.
//

import SwiftUI

struct AnnouncementListComponent: View {
    let announcement: String
    let primaryColor: Color
    
    var body: some View {
        VStack {
            Text(announcement)
                .font(.system(size: 16, weight: .ultraLight, design: .rounded))
                .multilineTextAlignment(.leading)
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 5)
        .frame(width: 250, height: 100)
        .background(
            LinearGradient(gradient: Gradient(colors: [primaryColor.opacity(0.2), primaryColor.opacity(0.7)]), startPoint: .top, endPoint: .bottom)
        )
        .cornerRadius(5)
    }
}

struct AnnouncementListComponent_Previews: PreviewProvider {
    static var previews: some View {
        AnnouncementListComponent(announcement: "Testing", primaryColor: Color("Blue"))
    }
}
