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
    @State var primaryColor = Color(.sRGB, red: 0.98, green: 0.9, blue: 0.2)
    @State var secondaryColor = Color(.sRGB, red: 0.98, green: 0.9, blue: 0.2)
    
    // MARK: - FUNCTIONS
    func createTeam() {
        let record = CKRecord(recordType: "Team", recordID: CKRecord.ID())

        if name != "" && location != "" && password != "" && confirmPassword != "" && confirmPassword == password {
            record["name"] = name
//            record["location"] = location
            record["password"] = password
//            record["coach"] = userID
            
            let publicDatabase = CKContainer.default().publicCloudDatabase
            publicDatabase.save(record) { recordResult, error in
                if error == nil {
                    print("Successful")
                }
                else {
                    print(error)
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
