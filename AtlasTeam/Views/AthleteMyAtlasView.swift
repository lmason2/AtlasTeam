//
//  AthleteMyAtlasView.swift
//  AtlasTeam
//
//  Created by Luke Mason on 1/28/22.
//

import SwiftUI

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
        upcomingPracticesLoaded = true
    }
    
    func getRaces() {
        // query for races
        upcomingRacesLoaded = true
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
                HStack(spacing: 0) {
                    Text("My Training")
                        .foregroundColor(Color(myTeam.secondaryColor))
                        .font(.system(size: 20, weight: .semibold, design: .rounded))
                    Spacer()
                    Text("Mileage:")
                        .foregroundColor(Color(myTeam.secondaryColor))
                        .font(.system(size: 12, weight: .semibold, design: .rounded))
                        .padding(.trailing, 0)
                        .frame(alignment: .trailing)
                    Text(sumMileage())
                        .foregroundColor(Color(myTeam.secondaryColor))
                        .font(.system(size: 12, weight: .semibold, design: .rounded))
                        .padding(.leading, 3)
                        .padding(.trailing, 5)
                        .frame(alignment: .leading)
                    Button(action: {
                        addTrainingSheet = true
                    }, label: {
                        Image(systemName: "plus.circle")
                            .foregroundColor(Color(myTeam.secondaryColor))
                    })
                    .padding(.trailing, 5)
                    Button(action: {
                        expandTraining = true
                    }, label: {
                        Image(systemName: "line.3.horizontal.circle")
                            .foregroundColor(Color(myTeam.secondaryColor))
                    })
                    .sheet(isPresented: $expandTraining) {
                        CompleteTrainingDetailView()
                    }
                }
                .padding(.horizontal, 10)
                .padding(.top, 10)
                .sheet(isPresented: $addTrainingSheet) {
                    NewTrainingSheetView(primaryColor: Color(myTeam.primaryColor), secondaryColor: Color(myTeam.secondaryColor), trainingType: .easy, additionalInfo: "")
                }
                
                Divider()
                if myTrainingLoaded {
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(0..<myTraining.count) {index in
                                NavigationLink(destination: TrainingDetailView(training: myTraining[index])) {
                                    TrainingListComponent(training: myTraining[index])
                                }
                                .tint(Color.black)
                            }
                        }
                    }
                    .padding()
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
