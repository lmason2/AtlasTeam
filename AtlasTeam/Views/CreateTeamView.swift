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
        coach["team"] = CKRecord.Reference(record: team, action: .none)

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
                let primaryColorString = UIColor(primaryColor).toHex
                let secondaryColorString = UIColor(secondaryColor).toHex
                record["password"] = password
                record["coach"] = CKRecord.Reference(record: coachRecord, action: .deleteSelf)
                record["primaryColor"] = primaryColorString ?? UIColor(Color.accentColor).toHex!
                record["secondaryColor"] = secondaryColorString ?? UIColor(Color("Blue")).toHex!

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
                } //: SAVE NEW TEAM
            } //: FIELD CHECKING
        } //: FETCH REFERENCE TO USER FOR COACH
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
            } //: SECTION
            
            Section("Colors") {
                VStack{
                    ColorPicker("Primary Color", selection: $primaryColor)
                        .foregroundColor(Color(.placeholderText))
                    ColorPicker("Secondary Color", selection: $secondaryColor)
                        .foregroundColor(Color(.placeholderText))
                } //: VSTACK
            } //: SECTION
            
            Section("Security") {
                SecureField (
                    "Password",
                    text: $password
                )
                .foregroundColor(Color.accentColor)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                
                SecureField (
                    "Confirm Password",
                    text: $confirmPassword
                )
                .foregroundColor(Color.accentColor)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
            } //: SECTION
            
            // Create team submit button
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
