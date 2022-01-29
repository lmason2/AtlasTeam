//
//  CoachMyAtlasView.swift
//  AtlasTeam
//
//  Created by Luke Mason on 1/28/22.
//

import SwiftUI

struct CoachMyAtlasView: View {
    let primaryColor: UIColor
    let secondaryColor: UIColor
    var body: some View {
        GroupBox("My Athletes") {
            Divider()
            ScrollView(.horizontal) {
                Text("text")
                Text("text")
            }
        }
        .foregroundColor(Color(secondaryColor))
        .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color(primaryColor), lineWidth: 2))
        .padding(.horizontal, 10)
        
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
        
        VStack {
            HStack {
                Text("My Training")
                .foregroundColor(Color(secondaryColor))
                Spacer()
                Button(action: {
                    print("adding training")
                }, label: {
                    Image(systemName: "plus")
                        .foregroundColor(Color(secondaryColor))
                })
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            Divider()
            ScrollView(.horizontal) {
                Text("text")
                Text("text")
            }
            .padding(.leading, 5)
        }
        .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color(primaryColor), lineWidth: 2))
        .background(Color(UIColor.systemGray6))
        .padding(.horizontal, 10)
        .padding(.vertical, 5)
        
    }
    
}

struct CoachMyAtlasView_Previews: PreviewProvider {
    static var previews: some View {
        CoachMyAtlasView(primaryColor: UIColor(), secondaryColor: UIColor())
    }
}
