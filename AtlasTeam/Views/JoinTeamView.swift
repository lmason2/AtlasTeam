//
//  JoinTeamView.swift
//  AtlasTeam
//
//  Created by Luke Mason on 1/28/22.
//

import SwiftUI
import CloudKit

struct JoinTeamView: View {
    // MARK: - PROPERTIES
    @State var newTeamMemberType: NewTeamMember = .none
    @State var name: String = ""
    @State var password: String = ""
    let userID = UserDefaults.standard.string(forKey: "userID")
    @AppStorage("team") var teamAppStorage: String = ""
    
    // MARK: - FUNCTIONS
    func joinTeam() {
        let publicDatabase = CKContainer.default().publicCloudDatabase
        let predicate = NSPredicate(format: "name == %@", name)
        let query = CKQuery(recordType: "Team", predicate: predicate)
        let operation = CKQueryOperation(query: query)
        operation.desiredKeys = ["password"]
        
        publicDatabase.perform(query, inZoneWith: nil) {results, error in
            if results == nil {
                // print team name doesn't exist
                return
            }
            else {
                let team = results![0]
                if password == team.value(forKey: "password") as! String {
                    let teamReference = CKRecord.Reference(record: team, action: .none)
                    publicDatabase.fetch(withRecordID: CKRecord.ID(recordName: userID!)) { (fetched, error) in
                        if let selfRecord = fetched {
                            selfRecord["team"] = teamReference
                            publicDatabase.save(selfRecord) { record, error in
                                if let error = error {
                                    print(error)
                                }
                                else {
                                    print("successfully added team to self")
                                    teamAppStorage = team.recordID.recordName
                                }
                            }
                            let selfReference = CKRecord.Reference(record: selfRecord, action: .none)
                            if var currentAthletes = team.value(forKey: "athletes") as? [CKRecord.Reference] {
                                currentAthletes.append(selfReference)
                                publicDatabase.save(team) { record, error in
                                    if let error = error {
                                        print(error)
                                    }
                                    else {
                                        print("successfully added self to team")
                                    }
                                }
                            }
                            else {
                                var currentAthletes: [CKRecord.Reference] = [selfReference]
                                team["athletes"] = currentAthletes
                                publicDatabase.save(team) { record, error in
                                    if let error = error {
                                        print(error)
                                    }
                                    else {
                                        print("successfully added self to team with no athletes")
                                    }
                                }
                            }
                        }
                        
                    }
                }
            }
        }
    }
    
    func getStringVersion() -> String {
        switch newTeamMemberType {
        case .trainer:
            return "Athletic Trainer"
        case .athlete:
            return "Athlete"
        case .assistant:
            return "Assistant Coach"
        case .none:
            return "Joining Team"
        }
    }
    
    // MARK: - BODY
    var body: some View {
        if newTeamMemberType != .none {
            Form {
                Section("Team Info") {
                    TextField(
                        "Team Name",
                        text: $name
                    )
                    .foregroundColor(Color.accentColor)
                    .disableAutocorrection(true)
                    .autocapitalization(.words)
                    
                    TextField(
                        "Password",
                        text: $password
                    )
                    .foregroundColor(Color.accentColor)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                }
                Button(action: {
                    withAnimation {
                        joinTeam()
                    }
                }, label: {
                    Text("Join Team")
                        .foregroundColor(Color("Blue"))
                })
                Button(action: {
                    withAnimation {
                        newTeamMemberType = .none
                    }
                }, label: {
                    Text("Go Back")
                        .foregroundColor(Color.accentColor)
                })
            } //: FORM
            .transition(.slide)
            .navigationTitle(getStringVersion())
        } //: CONDITIONAL
        else {
            VStack {
                Spacer()
                Button(action: {
                    withAnimation {
                        newTeamMemberType = .athlete
                    }
                }, label: {
                    Text("I'm an athlete")
                        .foregroundColor(.accentColor)
                        .frame(width: 200, height: 40)
                        .background(RoundedRectangle(cornerRadius: 3).stroke(Color.accentColor))
                })
                
                Button(action: {
                    withAnimation {
                        newTeamMemberType = .assistant
                    }
                }, label: {
                    Text("I'm an assistant coach")
                        .foregroundColor(Color("Blue"))
                        .frame(width: 200, height: 40)
                        .background(RoundedRectangle(cornerRadius: 3).stroke(Color("Blue")))
                })
                
                Button(action: {
                    withAnimation {
                        newTeamMemberType = .trainer
                    }
                }, label: {
                    Text("I'm an athletic trainer")
                        .foregroundColor(Color("Blue"))
                        .frame(width: 200, height: 40)
                        .background(RoundedRectangle(cornerRadius: 3).stroke(Color("Blue")))
                })
                Spacer()
            } //: VSTACK
            .transition(.slide)
            .padding()
            .navigationTitle("Joining Team")
        } //: CONDITIONAL
    }
}

struct JoinTeamView_Previews: PreviewProvider {
    static var previews: some View {
        JoinTeamView()
    }
}

enum NewTeamMember {
    case trainer
    case athlete
    case assistant
    case none
}
