//
//  NewPracticeSheetView.swift
//  AtlasTeam
//
//  Created by Luke Mason on 1/29/22.
//

import SwiftUI
import CloudKit

struct NewPracticeSheetView: View {
    @State var location: String = ""
    @State var additionalInfo: String = ""
    @State var date: Date = Calendar.current.date(byAdding: .day, value: +1, to: Date())!
    @State var successAlert: Bool = false
    @Binding var myTeam: Team
    @Binding var upcomingPracticesLoaded: Bool
    @Binding var displayingThisSheet: Bool
    @Binding var upcomingPractices: [Practice]
    
    func submitPractice() {
        let record = CKRecord(recordType: "Practice", recordID: CKRecord.ID())
        record["date"] = date
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
                        if var currentPracticeRecords = team.value(forKey: "practices") as? [CKRecord.Reference] {
                            currentPracticeRecords.append(CKRecord.Reference(record: recordResult!, action: .none))
                            team["practices"] = currentPracticeRecords
                            publicDatabase.save(team) { record, error in
                                if let error = error {
                                    print(error)
                                }
                                else {
                                    successAlert = true
                                    var practices = myTeam.practices
                                    practices.append(CKRecord.Reference(record: recordResult!, action: .none))
                                    upcomingPractices = []
                                    upcomingPracticesLoaded = false
                                    myTeam.practices = practices
                                }
                            }
                        }
                        else {
                            let practices = [CKRecord.Reference(record: recordResult!, action: .none)]
                            team["practices"] = practices
                            publicDatabase.save(team) { record, error in
                                if let error = error {
                                    print(error)
                                }
                                else {
                                    successAlert = true
                                    var practices = myTeam.practices
                                    practices.append(CKRecord.Reference(record: recordResult!, action: .none))
                                    upcomingPractices = []
                                    upcomingPracticesLoaded = false
                                    myTeam.practices = practices
                                }
                            }
                        }
                    }
                }
            }
            else {
                print("error")
                print("here")
                print(error ?? "")
            }
        } //: SAVE NEW TEAM
    }
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("Upcoming Practice")
                    .font(.system(size: 28, weight: .semibold, design: .rounded))
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            
            DatePicker(
                "Practice Time",
                selection: $date,
                displayedComponents: [.date, .hourAndMinute]
            )
            .padding(.horizontal)
            .font(.system(size: 18, weight: .semibold, design: .rounded))
            
            Divider()
            TextField(
                "Location",
                text: $location
            )
            .padding()
            Divider()
            
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
            
            Button(action: {
                submitPractice()
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
        .alert("Success posting practice", isPresented: $successAlert) {
            Button(action: {
                displayingThisSheet = false
            }, label: {
                Text("Okay")
            })
        }
    }
}
