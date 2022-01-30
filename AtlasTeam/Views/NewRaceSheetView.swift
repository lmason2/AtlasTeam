//
//  NewRaceSheetView.swift
//  AtlasTeam
//
//  Created by Luke Mason on 1/29/22.
//

import SwiftUI

import SwiftUI
import CloudKit

struct NewRaceSheetView: View {
    @State var name: String = ""
    @State var location: String = ""
    @State var additionalInfo: String = ""
    @State var date: Date = Date()
    @Binding var myTeam: Team
    @Binding var upcomingRacesLoaded: Bool
    @Binding var displayingThisSheet: Bool
    @Binding var upcomingRaces: [Race]
    @FocusState var infoFocused: Bool
    
    func submitRace() {
        let record = CKRecord(recordType: "Race", recordID: CKRecord.ID())
        record["date"] = date
        record["name"] = name
        record["additionalInfo"] = additionalInfo
        record["location"] = location

        let publicDatabase = CKContainer.default().publicCloudDatabase
        publicDatabase.save(record) { recordResult, error in
            if error == nil {
                let predicate = NSPredicate(format: "name == %@", myTeam.name)
                let query = CKQuery(recordType: "Team", predicate: predicate)
                publicDatabase.perform(query, inZoneWith: nil) {results, error in
                    if results == nil {
                        print("not found")
                        return
                    }
                    else {
                        let team = results![0]
                        let teamReference = CKRecord.Reference(record: team, action: .none)
                        if var currentRaceRecords = team.value(forKey: "races") as? [CKRecord.Reference] {
                            currentRaceRecords.append(CKRecord.Reference(record: recordResult!, action: .none))
                            team["races"] = currentRaceRecords
                            publicDatabase.save(team) { record, error in
                                if let error = error {
                                    print(error)
                                }
                                else {
                                    let race = Race(date: date, name: name, location: location, additionalInfo: additionalInfo)
                                    var races = myTeam.races
                                    races.append(CKRecord.Reference(record: recordResult!, action: .none))
                                    upcomingRaces = []
                                    upcomingRacesLoaded = false
                                    myTeam.races = races
                                    displayingThisSheet = false
                                }
                            }
                        }
                        else {
                            let races = [CKRecord.Reference(record: recordResult!, action: .none)]
                            team["races"] = races
                            publicDatabase.save(team) { record, error in
                                if let error = error {
                                    print(error)
                                }
                                else {
                                    let race = Race(date: date, name: name, location: location, additionalInfo: additionalInfo)
                                    var races = myTeam.races
                                    races.append(CKRecord.Reference(record: recordResult!, action: .none))
                                    upcomingRaces = []
                                    upcomingRacesLoaded = false
                                    myTeam.races = races
                                    displayingThisSheet = false
                                }
                            }
                        }
                    }
                }
            }
            else {
                print("error")
                print("here")
                print(error)
            }
        } //: SAVE NEW TEAM
    }
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("Upcoming Race")
                    .font(.system(size: 28, weight: .semibold, design: .rounded))
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            
            DatePicker(
                "Race Date",
                selection: $date,
                displayedComponents: [.date, .hourAndMinute]
            )
            .padding(.horizontal)
            .font(.system(size: 18, weight: .semibold, design: .rounded))
            
            VStack {
                Divider()
                TextField(
                    "Name",
                    text: $name
                )
                .padding()
                Divider()
                
                Divider()
                TextField(
                    "Location",
                    text: $location
                )
                .padding()
                Divider()
            }
            
            HStack {
                Spacer()
                Text("Additional Info")
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.top, 10)
            
            TextEditor(text: $additionalInfo)
            .foregroundColor(.black)
            .background(Color.white)
            .cornerRadius(10)
            .padding(EdgeInsets(top: 5, leading: 20, bottom: 5, trailing: 20))
            .frame(minHeight: 100, maxHeight: 200)
            .focused($infoFocused)
            
            Button(action: {
                submitRace()
            }, label: {
                Text("Submit")
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                    .foregroundColor(Color.white)
                    .overlay(Capsule().stroke(Color.white))
            })
            Spacer()
        }
        .onTapGesture {
            infoFocused = false
        }
    }
}
