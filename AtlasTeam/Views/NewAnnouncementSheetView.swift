//
//  NewAnnouncementSheetView.swift
//  AtlasTeam
//
//  Created by Luke Mason on 1/29/22.
//

import SwiftUI
import CloudKit

struct NewAnnouncementSheetView: View {
    @State var announcementContent: String = ""
    @Binding var myTeam: Team
    @Binding var announcementsLoaded: Bool
    @Binding var displayingThisSheet: Bool
    
    func submitAnnouncement() {
        let publicDatabase = CKContainer.default().publicCloudDatabase
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
                if var currentAnnouncements = team.value(forKey: "announcements") as? [String] {
                    currentAnnouncements.append(announcementContent)
                    team["announcements"] = currentAnnouncements
                    publicDatabase.save(team) { record, error in
                        if let error = error {
                            print(error)
                        }
                        else {
                            myTeam.announcements = currentAnnouncements
                            displayingThisSheet = false
                        }
                    }
                }
                else {
                    let announcements = [announcementContent]
                    team["announcements"] = announcements
                    publicDatabase.save(team) { record, error in
                        if let error = error {
                            print(error)
                        }
                        else {
                            myTeam.announcements = announcements
                            announcementsLoaded = true
                        }
                    }
                }
            }
        }
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
    }
}
