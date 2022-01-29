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
            Divider()
            ScrollView(.vertical) {
                if myTeam.coach.recordID.recordName == userID! {
                    Text("I'm a coach")
                    CoachMyAtlasView(primaryColor: myTeam.primaryColor, secondaryColor: myTeam.secondaryColor)
                }
                else if (checkAthletes()){
                    Text("I'm an athlete")
                    AthleteMyAtlasView(primaryColor: myTeam.primaryColor, secondaryColor: myTeam.secondaryColor)
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

