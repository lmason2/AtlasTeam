//
//  CoachMyAtlasView.swift
//  AtlasTeam
//
//  Created by Luke Mason on 1/28/22.
//

import SwiftUI
import CloudKit

struct CoachMyAtlasView: View {
    // MARK: - PROPERTIES
    let myTeam: Team
    @State var athletesLoaded: Bool = false
    @State var athletes: [Athlete] = []
    
    @State var upcomingPracticesLoaded: Bool = false
    @State var upcomingPractices: [Practice] = []
    
    @State var upcomingRacesLoaded: Bool = false
    @State var upcomingRaces: [Race] = []
    
    @State var myTrainingLoaded: Bool = false
    @State var addAnnouncementSheet: Bool = false
    @State var addPracticeSheet: Bool = false
    @State var addRaceSheet: Bool = false
    @State var addTrainingSheet: Bool = false
    
    func getPractices() {
        // query for practices
        upcomingPracticesLoaded = true
    }
    
    func getRaces() {
        // query for races
        upcomingRacesLoaded = true
    }
    
    func getTraining() {
        // query for training
        myTrainingLoaded = true
    }
    
    
    // MARK: - FUNCTIONS
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
                        let name = record?.value(forKey: "username") as! String
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
    
    // MARK: - BODY
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
                        HStack {
                            ForEach(0..<athletes.count) {index in
                                AthleteRowComponent(athlete: athletes[index], primaryColor: Color(myTeam.primaryColor))
                            }
                        }
                        .padding(.bottom, 10)
                    }
                    .padding()
                }
                else {
                    ProgressView().onAppear {
                        getAthletes()
                    }
                    .padding(.bottom, 10)
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
                        addAnnouncementSheet = true
                    }, label: {
                        Image(systemName: "plus.circle")
                            .foregroundColor(Color(myTeam.secondaryColor))
                    })
                }
                .padding(.horizontal, 10)
                .padding(.top, 10)
                .sheet(isPresented: $addAnnouncementSheet) {
                    NewAnnouncementSheetView()
                }
                Divider()
                
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(myTeam.announcements, id: \.self) {announcement in
                            AnnouncementListComponent(announcement: announcement, primaryColor: Color(myTeam.primaryColor))
                        }
                    }
                    .padding(.bottom, 10)
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
                        addPracticeSheet = true
                    }, label: {
                        Image(systemName: "plus.circle")
                            .foregroundColor(Color(myTeam.secondaryColor))
                    })
                }
                .padding(.horizontal, 10)
                .padding(.top, 10)
                .sheet(isPresented: $addPracticeSheet) {
                    NewPracticeSheetView()
                }
                
                Divider()
                if upcomingPracticesLoaded {
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(0..<upcomingPractices.count) {index in
                                PracticeListComponent(practice: upcomingPractices[index], secondaryColor: Color(myTeam.secondaryColor))
                            }
                        }
                    }
                    .padding()
                }
                else {
                    ProgressView().onAppear {
                        getPractices()
                    }
                    .padding(.bottom, 10)
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
                    Text("Upcoming Races")
                        .foregroundColor(Color(myTeam.secondaryColor))
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                    Spacer()
                    Button(action: {
                        addRaceSheet = true
                    }, label: {
                        Image(systemName: "plus.circle")
                            .foregroundColor(Color(myTeam.secondaryColor))
                    })
                }
                .padding(.horizontal, 10)
                .padding(.top, 10)
                .sheet(isPresented: $addRaceSheet) {
                    NewRaceSheetView()
                }
                
                Divider()
                if upcomingRacesLoaded {
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(0..<upcomingRaces.count) {index in
                                RaceListComponent(race: upcomingRaces[index], secondaryColor: Color(myTeam.secondaryColor))
                            }
                        }
                    }
                    .padding()
                }
                else {
                    ProgressView().onAppear {
                        getRaces()
                    }
                    .padding(.bottom, 10)
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
                    Text("My Training")
                        .foregroundColor(Color(myTeam.secondaryColor))
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                    Spacer()
                    Button(action: {
                        addTrainingSheet = true
                    }, label: {
                        Image(systemName: "plus.circle")
                            .foregroundColor(Color(myTeam.secondaryColor))
                    })
                }
                .padding(.horizontal, 10)
                .padding(.top, 10)
                .sheet(isPresented: $addTrainingSheet) {
                    NewTrainingSheetView(primaryColor: Color(myTeam.primaryColor), secondaryColor: Color(myTeam.secondaryColor), trainingType: .easy, additionalInfo: "")
                }
                
                Divider()
                if myTrainingLoaded {
                    ScrollView(.horizontal) {
                        Text("text")
                        Text("text")
                    }
                    .padding()
                }
                else {
                    ProgressView().onAppear {
                        
                    }
                    .padding(.bottom, 10)
                }
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
