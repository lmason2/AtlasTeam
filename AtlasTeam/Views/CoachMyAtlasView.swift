//
//  CoachMyAtlasView.swift
//  AtlasTeam
//
//  Created by Luke Mason on 1/28/22.
//

import SwiftUI
import CloudKit

struct CoachMyAtlasView: View {
    let myTeam: Team
    @State var athletesLoaded: Bool = false
    @State var athletes: [Athlete] = []
    
    func getAthletes() {
        let publicDatabase = CKContainer.default().publicCloudDatabase
        var recordIDs: [CKRecord.ID] = []
        for i in 0..<myTeam.athletes.count {
            recordIDs.append(myTeam.athletes[i].recordID)
        }
        publicDatabase.fetch(withRecordIDs: recordIDs) { result in
            do {
                // Create audio player object
                let results = try result.get()
                        
                print("looping")
                for i in 0..<recordIDs.count {
                    do {
                        let record = try results[recordIDs[i]]?.get()
                        let name = record?.value(forKey: "email") as! String
                        let mileage = 60
                        athletes.append(Athlete(name: name, mileage: mileage))
                    }
                    catch {
                        print("error")
                    }
                }
                athletesLoaded = true
            }
            catch {
                // Couldn't create audio player object, log the error
                print("Error")
            }
        }
    }
    
    var body: some View {
        VStack{
            VStack {
                HStack {
                    Text("My Athletes")
                        .foregroundColor(Color(myTeam.secondaryColor))
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                    Spacer()
                }
                .padding(.horizontal, 10)
                .padding(.top, 10)
                Divider()
                if athletesLoaded {
                    ScrollView(.horizontal) {
                        ForEach(0..<athletes.count) {index in
                            AthleteRowComponent(athlete: athletes[index], primaryColor: Color(myTeam.primaryColor))
                        }
                    }
                    .padding()
                }
                else {
                    ProgressView().onAppear {
                        getAthletes()
                    }
                }
            }
            .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color(myTeam.primaryColor), lineWidth: 2))
            .background(Color(UIColor.systemGray6))
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .clipped()
            .shadow(color: .gray, radius: 3, x: 0, y: 0)
            
            VStack {
                HStack {
                    Text("Team Announcements")
                    .foregroundColor(Color(myTeam.secondaryColor))
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                    Spacer()
                    Button(action: {
                        print("adding training")
                    }, label: {
                        Image(systemName: "plus.circle")
                            .foregroundColor(Color(myTeam.secondaryColor))
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
            .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color(myTeam.primaryColor), lineWidth: 2))
            .background(Color(UIColor.systemGray6))
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .clipped()
            .shadow(color: .gray, radius: 3, x: 0, y: 0)
            
            VStack {
                HStack {
                    Text("Upcoming Practices")
                    .foregroundColor(Color(myTeam.secondaryColor))
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                    Spacer()
                    Button(action: {
                        print("adding training")
                    }, label: {
                        Image(systemName: "plus.circle")
                            .foregroundColor(Color(myTeam.secondaryColor))
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
            .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color(myTeam.primaryColor), lineWidth: 2))
            .background(Color(UIColor.systemGray6))
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .clipped()
            .shadow(color: .gray, radius: 3, x: 0, y: 0)
            
            VStack {
                HStack {
                    Text("Upcoming Races")
                        .foregroundColor(Color(myTeam.secondaryColor))
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                    Spacer()
                    Button(action: {
                        print("adding training")
                    }, label: {
                        Image(systemName: "plus.circle")
                            .foregroundColor(Color(myTeam.secondaryColor))
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
            .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color(myTeam.primaryColor), lineWidth: 2))
            .background(Color(UIColor.systemGray6))
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .clipped()
            .shadow(color: .gray, radius: 3, x: 0, y: 0)
            
            VStack {
                HStack {
                    Text("My Training")
                        .foregroundColor(Color(myTeam.secondaryColor))
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                    Spacer()
                    Button(action: {
                        print("adding training")
                    }, label: {
                        Image(systemName: "plus.circle")
                            .foregroundColor(Color(myTeam.secondaryColor))
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
            .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color(myTeam.primaryColor), lineWidth: 2))
            .background(Color(UIColor.systemGray6))
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .clipped()
            .shadow(color: .gray, radius: 3, x: 0, y: 0)
            
        } //: VSTACK
    }
}
