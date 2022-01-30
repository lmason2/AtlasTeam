//
//  AthleteMyAtlasView.swift
//  AtlasTeam
//
//  Created by Luke Mason on 1/28/22.
//

import SwiftUI
import CloudKit

struct AthleteMyAtlasView: View {
    let myTeam: Team
    @State var athletesLoaded: Bool = false
    @State var athletes: [Athlete] = []
    
    @State var upcomingPracticesLoaded: Bool = false
    @State var upcomingPractices: [Practice] = []
    
    @State var upcomingRacesLoaded: Bool = false
    @State var upcomingRaces: [Race] = []
    
    @State var myTrainingLoaded: Bool = false
    @State var myTraining: [Training] = []
    
    @State var addAnnouncementSheet: Bool = false
    @State var addPracticeSheet: Bool = false
    @State var addRaceSheet: Bool = false
    @State var addTrainingSheet: Bool = false
    @State var expandTraining: Bool = false
    
    func getPractices() {
        // query for practices
        let publicDatabase = CKContainer.default().publicCloudDatabase
        var recordIDs: [CKRecord.ID] = []
        print("count - ", myTeam.practices.count)
        for i in 0..<myTeam.practices.count {
            recordIDs.append(myTeam.practices[i].recordID)
        }
        publicDatabase.fetch(withRecordIDs: recordIDs) { result in
            do {
                // Create audio player object
                let results = try result.get()
                        
                for i in 0..<recordIDs.count {
                    do {
                        let record = try results[recordIDs[i]]?.get()
                        let timestamp = record?.value(forKey: "date") as! Date
                        if timestamp >= Date() {
                            let location = record?.value(forKey: "location") as! String
                            let additionalInfo = record?.value(forKey: "additionalInfo") as! String
                            upcomingPractices.append(Practice(timestamp: timestamp, location: location, additionalInfo: additionalInfo))
                        }
                        
                    }
                    catch {
                        print("error")
                    }
                }
                upcomingPractices.sort(){$0.timestamp > $1.timestamp}
                upcomingPracticesLoaded = true
            }
            catch {
                // Couldn't create audio player object, log the error
                print("Error")
            }
        }
    }
    
    func getRaces() {
        // query for races
        let publicDatabase = CKContainer.default().publicCloudDatabase
        var recordIDs: [CKRecord.ID] = []
        for i in 0..<myTeam.races.count {
            recordIDs.append(myTeam.races[i].recordID)
        }
        publicDatabase.fetch(withRecordIDs: recordIDs) { result in
            do {
                // Create audio player object
                let results = try result.get()
                        
                for i in 0..<recordIDs.count {
                    do {
                        let record = try results[recordIDs[i]]?.get()
                        let date = record?.value(forKey: "date") as! Date
                        if date >= Date() {
                            let name = record?.value(forKey: "name") as! String
                            let location = record?.value(forKey: "location") as! String
                            let additionalInfo = record?.value(forKey: "additionalInfo") as! String
                            upcomingRaces.append(Race(date: date, name: name, location: location, additionalInfo: additionalInfo))
                        }
                        
                    }
                    catch {
                        print("error")
                    }
                }
                upcomingRacesLoaded = true
            }
            catch {
                // Couldn't create audio player object, log the error
                print("Error")
            }
        }
    }
    
    func getTraining() {
        // query for training
        myTraining = [
            Training(date: Date(), type: .easy, mileage: 10.0, minutes: 70, rating: 8, info: "Additional"),
            Training(date: Date(), type: .workout, mileage: 10.0, minutes: 60, rating: 9, info: "Additional"),
            Training(date: Date(), type: .race, mileage: 10.0, minutes: 60, rating: 9, info: "Additional"),
            Training(date: Date(), type: .mediumLong, mileage: 10.0, minutes: 60, rating: 9, info: "Additional"),
            Training(date: Date(), type: .long, mileage: 10.0, minutes: 60, rating: 9, info: "Additional"),
        ]
        myTrainingLoaded = true
    }
    
    func sumMileage() -> String {
        return "30"
    }
    
    var body: some View {
        VStack{
            VStack {
                HStack(spacing: 5) {
                    Text("My Training")
                        .foregroundColor(Color(myTeam.secondaryColor))
                        .font(.system(size: 20, weight: .semibold, design: .rounded))
                    Spacer()
                    HStack (spacing: 2) {
                        Text("Mileage:")
                            .foregroundColor(Color(myTeam.secondaryColor))
                            .font(.system(size: 12, weight: .semibold, design: .rounded))
                        Text(sumMileage())
                            .foregroundColor(Color(myTeam.secondaryColor))
                            .font(.system(size: 12, weight: .semibold, design: .rounded))
                    }
                    .padding(.vertical, 2)
                    .padding(.horizontal, 4)
                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color(myTeam.primaryColor), lineWidth: 1))
                   
                    Button(action: {
                        addTrainingSheet = true
                    }, label: {
                        Image(systemName: "plus.circle")
                            .foregroundColor(Color(myTeam.secondaryColor))
                    })
                    
                    Button(action: {
                        expandTraining = true
                    }, label: {
                        Image(systemName: "line.3.horizontal.circle")
                            .foregroundColor(Color(myTeam.secondaryColor))
                    })
                    .sheet(isPresented: $expandTraining) {
                        CompleteTrainingDetailView(training: myTraining)
                    }
                }
                .padding(.horizontal, 10)
                .padding(.top, 10)
                .sheet(isPresented: $addTrainingSheet) {
                    NewTrainingSheetView(primaryColor: Color(myTeam.primaryColor), secondaryColor: Color(myTeam.secondaryColor), trainingType: .easy, additionalInfo: "")
                        .background(LinearGradient(gradient: Gradient(colors: [Color(myTeam.primaryColor).opacity(0.3), Color(myTeam.secondaryColor).opacity(0.3)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                }
                
                Divider()
                if myTrainingLoaded {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(0..<myTraining.count) {index in
                                NavigationLink(destination: TrainingDetailView(training: myTraining[index])) {
                                    TrainingListComponent(training: myTraining[index])
                                }
                                .tint(Color.black)
                            }
                        }
                    }
                    .padding(.top, 10)
                    .padding(.bottom, 20)
                    .padding(.leading, 10)
                }
                else {
                    ProgressView().onAppear {
                        getTraining()
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
                }
                .padding(.horizontal, 10)
                .padding(.top, 10)
                Divider()
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(myTeam.announcements.reversed(), id: \.self) {announcement in
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
                }
                .padding(.horizontal, 10)
                .padding(.top, 10)
                
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
                }
                .padding(.horizontal, 10)
                .padding(.top, 10)
                
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
            
        } //: VSTACK
    }
}
