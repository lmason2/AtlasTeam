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
        VStack{
            VStack {
                HStack {
                    Text("My Athletes")
                    .foregroundColor(Color(secondaryColor))
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                    Spacer()
                }
                .padding(.horizontal, 10)
                .padding(.top, 10)
                Divider()
                ScrollView(.horizontal) {
                    Text("text")
                    Text("text")
                }
                .padding()
            }
            .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color(primaryColor), lineWidth: 2))
            .background(Color(UIColor.systemGray6))
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            
            VStack {
                HStack {
                    Text("Team Announcements")
                    .foregroundColor(Color(secondaryColor))
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                    Spacer()
                    Button(action: {
                        print("adding training")
                    }, label: {
                        Image(systemName: "plus.circle")
                            .foregroundColor(Color(secondaryColor))
                    })
                }
                .padding(.horizontal, 10)
                .padding(.top, 10)
                Divider()
                ScrollView(.horizontal) {
                    Text("text")
                    Text("text")
                }
                .padding()
            }
            .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color(primaryColor), lineWidth: 2))
            .background(Color(UIColor.systemGray6))
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            
            VStack {
                HStack {
                    Text("Upcoming Practices")
                    .foregroundColor(Color(secondaryColor))
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                    Spacer()
                    Button(action: {
                        print("adding training")
                    }, label: {
                        Image(systemName: "plus.circle")
                            .foregroundColor(Color(secondaryColor))
                    })
                }
                .padding(.horizontal, 10)
                .padding(.top, 10)
                Divider()
                ScrollView(.horizontal) {
                    Text("text")
                    Text("text")
                }
                .padding()
            }
            .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color(primaryColor), lineWidth: 2))
            .background(Color(UIColor.systemGray6))
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            
            VStack {
                HStack {
                    Text("Upcoming Races")
                    .foregroundColor(Color(secondaryColor))
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                    Spacer()
                    Button(action: {
                        print("adding training")
                    }, label: {
                        Image(systemName: "plus.circle")
                            .foregroundColor(Color(secondaryColor))
                    })
                }
                .padding(.horizontal, 10)
                .padding(.top, 10)
                Divider()
                ScrollView(.horizontal) {
                    Text("text")
                    Text("text")
                }
                .padding()
            }
            .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color(primaryColor), lineWidth: 2))
            .background(Color(UIColor.systemGray6))
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            
            VStack {
                HStack {
                    Text("My Training")
                    .foregroundColor(Color(secondaryColor))
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                    Spacer()
                    Button(action: {
                        print("adding training")
                    }, label: {
                        Image(systemName: "plus.circle")
                            .foregroundColor(Color(secondaryColor))
                    })
                }
                .padding(.horizontal, 10)
                .padding(.top, 10)
                Divider()
                ScrollView(.horizontal) {
                    Text("text")
                    Text("text")
                }
                .padding()
            }
            .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color(primaryColor), lineWidth: 2))
            .background(Color(UIColor.systemGray6))
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            
        } //: VSTACK
    }
}

struct CoachMyAtlasView_Previews: PreviewProvider {
    static var previews: some View {
        CoachMyAtlasView(primaryColor: UIColor(), secondaryColor: UIColor())
    }
}
