//
//  AthleteMyAtlasView.swift
//  AtlasTeam
//
//  Created by Luke Mason on 1/28/22.
//

import SwiftUI

struct AthleteMyAtlasView: View {
    let primaryColor: UIColor
    let secondaryColor: UIColor
    var body: some View {
        GroupBox("Team Announcements") {
            Divider()
            ScrollView(.horizontal) {
                Text("text")
                Text("text")
            }
        }
        .foregroundColor(Color(secondaryColor))
        .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color(primaryColor), lineWidth: 2))
        .padding(.horizontal, 10)
        
        GroupBox("My Training") {
            Divider()
            ScrollView(.horizontal) {
                Text("text")
                Text("text")
            }
        }
        .foregroundColor(Color(secondaryColor))
        .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color(primaryColor), lineWidth: 2))
        .padding(.horizontal, 10)
        
        GroupBox("Upcoming Practices") {
            Divider()
            ScrollView(.horizontal) {
                Text("text")
                Text("text")
            }
        }
        .foregroundColor(Color(secondaryColor))
        .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color(primaryColor), lineWidth: 2))
        .padding(.horizontal, 10)
        
        GroupBox("Upcoming Races") {
            Divider()
            ScrollView(.horizontal) {
                Text("text")
                Text("text")
            }
        }
        .foregroundColor(Color(secondaryColor))
        .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color(primaryColor), lineWidth: 2))
        .padding(.horizontal, 10)
    }
}

struct AthleteMyAtlasView_Previews: PreviewProvider {
    static var previews: some View {
        AthleteMyAtlasView(primaryColor: UIColor(), secondaryColor: UIColor())
    }
}
