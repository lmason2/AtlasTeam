//
//  CreateTeamView.swift
//  AtlasTeam
//
//  Created by Luke Mason on 1/28/22.
//

import SwiftUI
import CloudKit

struct CreateTeamView: View {
    // MARK: - PROPERTIES
    @State var name: String = ""
    @State var location: String = ""
    @State var password: String = ""
    @State var confirmPassword: String = ""
    @State var primaryColor = Color(.sRGB, red: 0, green: 0, blue: 0)
    @State var secondaryColor = Color(.sRGB, red: 0, green: 0, blue: 0)
    @AppStorage("team") var teamAppStorage: String = ""
    let userID = UserDefaults.standard.string(forKey: "userID")
    
    // MARK: - FUNCTIONS
    func addTeamToCoach(coach: CKRecord, team: CKRecord) {
        let publicDatabase = CKContainer.default().publicCloudDatabase
        let reference = CKRecord.Reference(record: coach, action: .none)
        print(reference)
        coach["team"] = CKRecord.Reference(record: team, action: .none)

        print("trying to save")
        print(coach)
        publicDatabase.save(coach) { record, error in
            if let error = error {
                print(error)
            }
            else {
                print("successful")
                teamAppStorage = team.recordID.recordName
            }
        }
    }
    
    func createTeam() {
        let publicDatabase = CKContainer.default().publicCloudDatabase
        publicDatabase.fetch(withRecordID: CKRecord.ID(recordName: userID!)) { (fetched, error) in
            guard let coachRecord = fetched else {
                print("returning")
                return
            }
            if name != "" && location != "" && password != "" && confirmPassword != "" && confirmPassword == password {
                let record = CKRecord(recordType: "Team", recordID: CKRecord.ID())
                record["name"] = name
    //            record["location"] = location
                record["password"] = password
                record["coach"] = CKRecord.Reference(record: coachRecord, action: .deleteSelf)

                let publicDatabase = CKContainer.default().publicCloudDatabase
                publicDatabase.save(record) { recordResult, error in
                    if error == nil {
                        print("New Team Successful")
                        addTeamToCoach(coach: coachRecord, team: recordResult!)
                    }
                    else {
                        print("error")
                        print(error)
                    }
                }
            }
        }
    }
    
    // MARK: - BODY
    var body: some View {
        Form {
            Section("Basic Info") {
                TextField(
                    "Name",
                    text: $name
                )
                .foregroundColor(Color.accentColor)
                .disableAutocorrection(true)
                .autocapitalization(.words)
                
                TextField(
                    "Location",
                    text: $location
                )
                .foregroundColor(Color.accentColor)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
            }
            
            Section("Colors") {
                VStack{
                    ColorPicker("Primary Color", selection: $primaryColor)
                        .foregroundColor(Color(.placeholderText))
                    ColorPicker("Secondary Color", selection: $secondaryColor)
                        .foregroundColor(Color(.placeholderText))
                }
                
            }
            
            Section("Security") {
                TextField(
                    "Password",
                    text: $password
                )
                .foregroundColor(Color.accentColor)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                
                TextField(
                    "Confirm Password",
                    text: $confirmPassword
                )
                .foregroundColor(Color.accentColor)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
            }
            Button(action: {
                createTeam()
            }, label: {
                Text("Create Team")
                    .foregroundColor(Color("Blue"))
            })
        }
        .navigationBarTitle("Create Team")
    }
}

struct CreateTeamView_Previews: PreviewProvider {
    static var previews: some View {
        CreateTeamView()
    }
}
