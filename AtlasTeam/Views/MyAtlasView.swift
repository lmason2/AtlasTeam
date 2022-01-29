//
//  MyAtlasView.swift
//  AtlasTeam
//
//  Created by Luke Mason on 1/28/22.
//

import SwiftUI
import CloudKit

struct MyAtlasView: View {
    // MARK: - PROPERTIES
    let userID = UserDefaults.standard.string(forKey: "userID")
    let email = UserDefaults.standard.string(forKey: "email")
    let username = UserDefaults.standard.string(forKey: "username")
    let team = UserDefaults.standard.string(forKey: "team")
    let myTeam: Team
    @State var teamName: String = ""
    
    // MARK: - FUNCTIONS
    func checkAthletes() -> Bool {
        for i in 0..<myTeam.athletes.count {
            if myTeam.athletes[i].recordID.recordName == userID! {
                return true
            }
        }
        return false
    }
    
    func checkTrainers() -> Bool {
        for i in 0..<myTeam.trainers.count {
            if myTeam.trainers[i].recordID.recordName == userID! {
                return true
            }
        }
        return false
    }
    
    func checkAssistants() -> Bool {
        for i in 0..<myTeam.assistantCoaches.count {
            if myTeam.assistantCoaches[i].recordID.recordName == userID! {
                return true
            }
        }
        return false
    }
    
    // MARK: - BODY
    var body: some View {
        VStack {
            HStack {
                Text("\(myTeam.city), \(myTeam.state)")
                    .font(.subheadline)
                Spacer()
            }
            .padding(.leading, 20)
            Divider()
            
            ScrollView(.vertical, showsIndicators: false) {
                if myTeam.coach.recordID.recordName == userID! {
                    CoachMyAtlasView(myTeam: myTeam)
                }
                else if (checkAthletes()){
                    AthleteMyAtlasView(myTeam: myTeam)
                }
                else if (checkTrainers()) {
                    Text("I'm a trainer")
                }
                else if (checkAssistants()) {
                    Text("I'm an assistant")
                }
            }
        } //: VSTACK
        .navigationTitle(myTeam.name)
    }
}

