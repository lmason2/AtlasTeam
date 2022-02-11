//
//  AnnouncementDetailView.swift
//  AtlasTeam
//
//  Created by Luke Mason on 2/2/22.
//

import SwiftUI

struct AnnouncementDetailView: View {
    let myTeam: Team
    let announcement: Announcement
    var body: some View {
        VStack {
            Text(announcement.title)
                .font(.system(size: 32, weight: .semibold, design: .rounded))
                .multilineTextAlignment(.leading)
                .lineLimit(nil)
            Divider()
            ScrollView(.vertical, showsIndicators: false) {
                Group {
                    HStack {
                        Spacer()
                        Text(announcement.content)
                            .font(.system(size: 20, weight: .medium, design: .rounded))
                            .padding()
                        Spacer()
                    }
                }
                .shadow(color: Color.black.opacity(0.15), radius: 5)
                .border(.white, width: 2)
                .cornerRadius(5)
                .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
            }
            .frame(width: UIScreen.main.bounds.width * 0.9)
        }
        .padding(.top, 20)
        .padding(.horizontal, 5)
        .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.85)
        .background(LinearGradient(gradient: Gradient(colors: [Color(myTeam.primaryColor).opacity(0.5), Color(myTeam.secondaryColor).opacity(0.5)]), startPoint: .topLeading, endPoint: .bottomTrailing))
        .cornerRadius(10)
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }
}
