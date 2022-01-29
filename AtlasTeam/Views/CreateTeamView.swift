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
    @State var city: String = ""
    @State var state: String = ""
    @State var password: String = ""
    @State var confirmPassword: String = ""
    @State var primaryColor = Color(.sRGB, red: 0, green: 0, blue: 0)
    @State var secondaryColor = Color(.sRGB, red: 0, green: 0, blue: 0)
    @State var showAlert: Bool = false
    @State var message: String = ""
    @AppStorage("team") var teamAppStorage: String = ""
    @AppStorage("dataLoaded") var dataLoaded: Bool = false
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
                dataLoaded = false
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
            if name != "" && city != "" && state != "" && password != "" && confirmPassword != "" && confirmPassword == password {
                let publicDatabase = CKContainer.default().publicCloudDatabase
                let predicate = NSPredicate(format: "name == %@", name)
                let query = CKQuery(recordType: "Team", predicate: predicate)
                publicDatabase.perform(query, inZoneWith: nil) {results, error in
                    if results == [] {
                        let record = CKRecord(recordType: "Team", recordID: CKRecord.ID())
                        record["name"] = name
                        record["city"] = city
                        record["state"] = state
                        let primaryColorString = UIColor(primaryColor).toHex
                        let secondaryColorString = UIColor(secondaryColor).toHex
                        record["password"] = password
                        record["coach"] = CKRecord.Reference(record: coachRecord, action: .deleteSelf)
                        record["primaryColor"] = primaryColorString ?? UIColor(Color.accentColor).toHex!
                        record["secondaryColor"] = secondaryColorString ?? UIColor(Color("Blue")).toHex!

                        publicDatabase.save(record) { recordResult, error in
                            if error == nil {
                                print("New Team Successful")
                                name = ""
                                city = ""
                                state = ""
                                password = ""
                                confirmPassword = ""
                                addTeamToCoach(coach: coachRecord, team: recordResult!)
                            }
                            else {
                                print("error")
                                print(error)
                            }
                        } //: SAVE NEW TEAM
                        return
                    } //: TEAM NAME CHECK PASSED
                    else {
                        print(results)
                        message = "Team name already exists"
                        showAlert = true
                    } //: TEAM NAME ALREADY EXISTS
                } //: QUERY FOR TEAM NAME EXISTS
            } //: FIELD CHECKING
            else {
                message = "Fill all fields"
                showAlert = true
            }
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
                .autocapitalization(.words)
                
                TextField(
                    "City",
                    text: $city
                )
                .foregroundColor(Color.accentColor)
                .autocapitalization(.words)
                
                TextField(
                    "State",
                    text: $state
                )
                .foregroundColor(Color.accentColor)
                .autocapitalization(.words)
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
        .alert(message, isPresented: $showAlert) {
            Button("OK", role: .cancel) { }
        }
    }
}

struct CreateTeamView_Previews: PreviewProvider {
    static var previews: some View {
        CreateTeamView()
    }
}
