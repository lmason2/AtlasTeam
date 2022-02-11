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
    @State var myTeam: Team
    @State var athletesLoaded: Bool = false
    @State var athletes: [Athlete] = []
    
    @State var upcomingPracticesLoaded: Bool = false
    @State var upcomingPractices: [Practice] = []
    
    @State var upcomingRacesLoaded: Bool = false
    @State var upcomingRaces: [Race] = []
    
    @State var athleteActivitiesLoaded: Bool = false

    @State var announcementsLoaded: Bool = false
    @State var announcements: [Announcement] = []
    
    @State var myTrainingLoaded: Bool = false
    @State var myTraining: [Training] = []
    
    @State var addAnnouncementSheet: Bool = false
    @State var addPracticeSheet: Bool = false
    @State var addRaceSheet: Bool = false
    @State var addTrainingSheet: Bool = false
    @State var expandTraining: Bool = false
    @State var expandAthletes: Bool = false
    
    @State var filteredTraining: [Training] = []
    
    let userID = UserDefaults.standard.string(forKey: "userID")
    let username = UserDefaults.standard.string(forKey: "username")
    
    // MARK: - FUNCTIONS
    func sumMileage() -> String {
        var sum = 0.00
        for i in 0..<filteredTraining.count {
            sum += filteredTraining[i].mileage
        }
        return String(sum)
    }
    
    func getAnnouncements() {
        // query for practices
        let publicDatabase = CKContainer.default().publicCloudDatabase
        var recordIDs: [CKRecord.ID] = []
        for i in 0..<myTeam.announcements.count {
            recordIDs.append(myTeam.announcements[i].recordID)
        }
        publicDatabase.fetch(withRecordIDs: recordIDs) { result in
            do {
                // Create audio player object
                let results = try result.get()
                        
                for i in 0..<recordIDs.count {
                    do {
                        let record = try results[recordIDs[i]]?.get()
                        let title = record?.value(forKey: "title") as! String
                        let content = record?.value(forKey: "content") as! String
                        announcements.append(Announcement(title: title, content: content))
                    }
                    catch {
                        print("error")
                    }
                }
                announcements.reverse()
                announcementsLoaded = true
            }
            catch {
                // Couldn't create audio player object, log the error
                print("Error")
            }
        }
    }
    
    func getPractices() {
        // query for practices
        let publicDatabase = CKContainer.default().publicCloudDatabase
        var recordIDs: [CKRecord.ID] = []
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
        let publicDatabase = CKContainer.default().publicCloudDatabase
        publicDatabase.fetch(withRecordID: CKRecord.ID(recordName: userID!)) { (fetched, error) in
            if error == nil {
                let trainingRecords = fetched?.value(forKey: "activities") as? [CKRecord.Reference] ?? []
                var recordIDs: [CKRecord.ID] = []
                for i in 0..<trainingRecords.count {
                    recordIDs.append(trainingRecords[i].recordID)
                }
                publicDatabase.fetch(withRecordIDs: recordIDs) { result in
                    do {
                        // Create audio player object
                        let results = try result.get()
                                
                        print(results)
                        for i in 0..<recordIDs.count {
                            do {
                                let record = try results[recordIDs[i]]?.get()
                                let name = CKRecord.Reference(record: record!, action: .none)
                                let additionalInfo = record?.value(forKey: "additionalInfo") as? String ?? ""
                                let date = record?.value(forKey: "date") as? Date ?? Date()
                                let mileage = record?.value(forKey: "mileage") as? Double ?? 0.00
                                let minutes = record?.value(forKey: "minutes") as? Double ?? 0.00
                                let typeString = record?.value(forKey: "type") as? String ?? "Easy"
                                let type = getTrainingTypeFromString(typeString)
                                var raceDistance = ""
                                var raceTime = ""
                                if type == .race {
                                    raceDistance = record?.value(forKey: "raceDistance") as? String ?? ""
                                    raceTime = record?.value(forKey: "raceTime") as? String ?? ""
                                }
                                let rating = record?.value(forKey: "rating") as? Int ?? 5
                                let training = Training(name: name, date: date, type: type, mileage: mileage, minutes: minutes, rating: rating, info: additionalInfo, raceDistance: raceDistance, raceTime: raceTime)
                                myTraining.append(training)
                                
                            }
                            catch {
                                print("error")
                            }
                        }
                        myTraining.sort(){$0.date > $1.date}
                        let newestDate = Date()
                        for i in 0..<7 {
                            let dateToCheck = Calendar.current.date(byAdding: .day, value: -i, to: newestDate)!
                            if Calendar.current.dateComponents([.weekday], from: dateToCheck).weekday == (myTeam.weekStartsOnMonday ? 1 : 7) {
                                break
                            }
                        }
                        let minMax = getMinMaxThisWeek(weekStartsOnMonday: myTeam.weekStartsOnMonday)
                        filteredTraining =  myTraining.compactMap({ $0 as Training }).filter { $0.date >= minMax[0] && $0.date <= minMax[1]}
                        filteredTraining.reverse()
                        myTrainingLoaded = true
                    }
                    catch {
                        // Couldn't create audio player object, log the error
                        print("Error")
                    }
                }
            }
            else {
                print("error")
                print(error ?? "")
            }
        }
    }
    
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
                        
                for i in 0..<recordIDs.count {
                    do {
                        let record = try results[recordIDs[i]]?.get()
                        let username = record?.value(forKey: "username") as! String
                        let email = record?.value(forKey: "email") as! String
                        let activitiesReferences = record?.value(forKey: "activities") as? [CKRecord.Reference] ?? []
                        
                        athletes.append(Athlete(username: username, email: email, activityRecords: activitiesReferences, activitiesUnwrapped: []))
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
    
    func getAthleteActivities() {
        let publicDatabase = CKContainer.default().publicCloudDatabase
        for i in 0..<athletes.count {
            var recordIDs: [CKRecord.ID] = []
            for j in 0..<athletes[i].activityRecords.count {
                recordIDs.append(athletes[i].activityRecords[j].recordID)
            }
            publicDatabase.fetch(withRecordIDs: recordIDs) { result in
                do {
                    // Create audio player object
                    let results = try result.get()
                            
                    for k in 0..<recordIDs.count {
                        do {
                            let record = try results[recordIDs[k]]?.get()
                            let name = CKRecord.Reference(record: record!, action: .none)
                            let date = record?.value(forKey: "date") as! Date
                            let typeString = record?.value(forKey: "type") as! String
                            let mileage = record?.value(forKey: "mileage") as! Double
                            let minutes = record?.value(forKey: "minutes") as? Double ?? nil
                            let rating = record?.value(forKey: "rating") as! Int
                            let info = record?.value(forKey: "additionalInfo") as! String
                            
                            athletes[i].activitiesUnwrapped.append(Training(name: name, date: date, type: getTrainingTypeFromString(typeString), mileage: mileage, minutes: minutes, rating: rating, info: info))
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
        athleteActivitiesLoaded = true
    }
    
    // MARK: - BODY
    var body: some View {
        VStack{
            VStack {
                HStack {
                    Text("My Athletes - This Week")
                        .foregroundColor(Color(myTeam.secondaryColor))
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                    Spacer()
                    Button(action: {
                    }, label: {
                        NavigationLink(destination: AllAthletesView(athletes: athletes, primaryColor: Color(myTeam.primaryColor), secondaryColor: Color(myTeam.secondaryColor), weekStartsOnMonday: myTeam.weekStartsOnMonday, myTeam: myTeam), label: {
                            Image(systemName: "line.3.horizontal.circle")
                                .foregroundColor(Color(myTeam.secondaryColor))
                        })
                    })
                }
                .padding(.horizontal, 10)
                .padding(.top, 10)
                Divider()
                if athletesLoaded {
                    if athleteActivitiesLoaded {
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(0..<athletes.count) {index in
                                    let minMax = getMinMaxThisWeek(weekStartsOnMonday: myTeam.weekStartsOnMonday)
                                    let filteredTraining = athletes[index].activitiesUnwrapped.filter { $0.date >= minMax[0] && $0.date <= minMax[1]}
                                    NavigationLink(destination: SpecificWeekTrainingView(training: filteredTraining, minDate: minMax[0], maxDate:minMax[1], primaryColor: Color(myTeam.primaryColor), secondaryColor: Color(myTeam.secondaryColor), myTeam: myTeam), label: {
                                        AthleteRowComponent(athlete: athletes[index], primaryColor: Color(myTeam.primaryColor), weekStartsOnMonday: myTeam.weekStartsOnMonday, stats: getStats(filteredTraining))
                                    })
                                    .tint(Color.black)
                                }
                            }
                            .padding(.bottom, 10)
                            .padding(.horizontal, 20)
                        }
                        .padding(.vertical)
                    }
                    else {
                        ProgressView().onAppear {
                            getAthleteActivities()
                        }
                        .padding(.bottom, 10)
                    }
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
                    NewAnnouncementSheetView(myTeam: $myTeam, announcementsLoaded: $announcementsLoaded, displayingThisSheet: $addAnnouncementSheet, announcements: $announcements)
                        .background(LinearGradient(gradient: Gradient(colors: [Color(myTeam.primaryColor).opacity(0.3), Color(myTeam.secondaryColor).opacity(0.3)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                }
                Divider()
                
                if announcementsLoaded {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(0..<announcements.count) {index in
                                NavigationLink(destination: AnnouncementDetailView(myTeam: myTeam, announcement: announcements[index]), label: {
                                    AnnouncementListComponent(announcement: announcements[index], primaryColor: Color(myTeam.primaryColor))
                                })
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 10)
                    }
                    .padding(.vertical)
                }
                else {
                    ProgressView().onAppear {
                        print("getting announcements")
                        getAnnouncements()
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
                    NewPracticeSheetView(myTeam: $myTeam, upcomingPracticesLoaded: $upcomingPracticesLoaded, displayingThisSheet: $addPracticeSheet, upcomingPractices: $upcomingPractices)
                        .background(LinearGradient(gradient: Gradient(colors: [Color(myTeam.primaryColor).opacity(0.3), Color(myTeam.secondaryColor).opacity(0.3)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                }
                
                Divider()
                if upcomingPracticesLoaded {
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(0..<upcomingPractices.count) {index in
                                PracticeListComponent(practice: upcomingPractices[index], secondaryColor: Color(myTeam.secondaryColor))
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 10)
                    }
                    .padding(.vertical)
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
                    NewRaceSheetView(myTeam: $myTeam, upcomingRacesLoaded: $upcomingRacesLoaded, displayingThisSheet: $addRaceSheet, upcomingRaces: $upcomingRaces)
                        .background(LinearGradient(gradient: Gradient(colors: [Color(myTeam.primaryColor).opacity(0.3), Color(myTeam.secondaryColor).opacity(0.3)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                }
                
                Divider()
                if upcomingRacesLoaded {
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(0..<upcomingRaces.count) {index in
                                RaceListComponent(race: upcomingRaces[index], secondaryColor: Color(myTeam.secondaryColor))
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 10)
                    }
                    .padding(.vertical)
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
                    Text("Training - This Week")
                        .foregroundColor(Color(myTeam.secondaryColor))
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                    Spacer()
                    if myTrainingLoaded {
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
                        }, label: {
                            NavigationLink(destination: CompleteTrainingDetailView(training: myTraining, weekStartsOnMonday: myTeam.weekStartsOnMonday, username: username!, primaryColor: Color(myTeam.primaryColor), secondaryColor: Color(myTeam.secondaryColor), myTeam: myTeam), label: {
                                Image(systemName: "line.3.horizontal.circle")
                                    .foregroundColor(Color(myTeam.secondaryColor))
                            })
                        })
                    }
                }
                .padding(.horizontal, 10)
                .padding(.top, 10)
                .sheet(isPresented: $addTrainingSheet) {
                    NewTrainingSheetView(primaryColor: Color(myTeam.primaryColor), secondaryColor: Color(myTeam.secondaryColor), trainingType: .easy, additionalInfo: "", myTrainingLoaded: $myTrainingLoaded, displayingThisSheet: $addTrainingSheet, myTrainings: $myTraining)
                        .background(LinearGradient(gradient: Gradient(colors: [Color(myTeam.primaryColor).opacity(0.3), Color(myTeam.secondaryColor).opacity(0.3)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                }
                
                Divider()
                if myTrainingLoaded {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(0..<filteredTraining.count) {index in
                                NavigationLink(destination: TrainingDetailView(training: filteredTraining[index], myTeam: myTeam, coachesView: false, myTrainingLoaded: $myTrainingLoaded)) {
                                    TrainingListComponent(training: filteredTraining[index])
                                }
                                .tint(Color.black)
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 10)
                    }
                    .padding(.vertical)
                }
                else {
                    ProgressView().onAppear {
                        if filteredTraining.count != 0 || myTraining.count != 0 {
                            myTraining = []
                            filteredTraining = []
                        }
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
            
        } //: VSTACK
    }
}
