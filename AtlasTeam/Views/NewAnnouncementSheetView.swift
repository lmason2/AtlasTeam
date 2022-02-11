//
//  NewAnnouncementSheetView.swift
//  AtlasTeam
//
//  Created by Luke Mason on 1/29/22.
//

import SwiftUI
import CloudKit

struct NewAnnouncementSheetView: View {
    @State var announcementTitle: String = ""
    @State var announcementContent: String = ""
    @State var successAlert: Bool = false
    @Binding var myTeam: Team
    @Binding var announcementsLoaded: Bool
    @Binding var displayingThisSheet: Bool
    @Binding var announcements: [Announcement]
    @AppStorage("team") var teamAppStorage: String = ""
    
    func submitAnnouncement() {
        let record = CKRecord(recordType: "Announcement", recordID: CKRecord.ID())
        record["title"] = announcementTitle
        record["content"] = announcementContent
        record["teamName"] = teamAppStorage

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
                        if var currentAnnouncements = team.value(forKey: "announcements") as? [CKRecord.Reference] {
                            currentAnnouncements.append(CKRecord.Reference(record: recordResult!, action: .none))
                            team["announcements"] = currentAnnouncements
                            publicDatabase.save(team) { record, error in
                                if let error = error {
                                    print(error)
                                }
                                else {
                                    successAlert = true
                                    announcements = []
                                    announcementsLoaded = false
                                    myTeam.announcements = currentAnnouncements
                                }
                            }
                        }
                        else {
                            let currentAnnouncements = [CKRecord.Reference(record: recordResult!, action: .none)]
                            team["announcements"] = currentAnnouncements
                            publicDatabase.save(team) { record, error in
                                if let error = error {
                                    print(error)
                                }
                                else {
                                    successAlert = true
                                    announcements = []
                                    announcementsLoaded = false
                                    myTeam.practices = currentAnnouncements
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
                Text("Announcement")
                    .font(.system(size: 28, weight: .semibold, design: .rounded))
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            
            TextField(
                "Announcement Title",
                text: $announcementTitle
            )
            .padding()
            
            TextEditor(text: $announcementContent)
            .foregroundColor(.black)
            .background(Color.white)
            .cornerRadius(10)
            .padding(EdgeInsets(top: 5, leading: 20, bottom: 5, trailing: 20))
            .frame(minHeight: 100, maxHeight: 200)
            
            Button(action: {
                submitAnnouncement()
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
        .alert("Success posting announcement", isPresented: $successAlert) {
            Button(action: {
                displayingThisSheet = false
            }, label: {
                Text("Okay")
            })
        }
    }
}
