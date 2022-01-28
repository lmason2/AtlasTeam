//
//  LogInComponent.swift
//  AtlasTeam
//
//  Created by Luke Mason on 1/27/22.
//

import SwiftUI
import AuthenticationServices
import CloudKit

struct LogInComponent: View {
    @AppStorage("isAuthenticated") var isAuthenticated: Bool = false
    @Binding var wantsToLogIn: Bool
    @Binding var wantsToSignUp: Bool
    @Binding var signingUpWithEmail: Bool
    
    var body: some View {
        VStack {
            VStack{
                HStack{
                    Spacer()
                    Button(action: {
                        withAnimation(.easeIn(duration: 0.5)) {
                            signingUpWithEmail = true
                        }
                    }, label: {
                        HStack(spacing: 3) {
                            Image(systemName: "person")
                                .font(.system(size: 16))
                            Text("Sign in with Email")
                                .font(.system(size: 19, weight: .medium, design: .rounded))
                                .foregroundColor(Color("Blue"))
                        }
                        .padding(.vertical, 12)
                        .padding(.horizontal, 15)
                        
                    })
                    .background(RoundedRectangle(cornerRadius: 5).stroke(Color.accentColor, lineWidth: 0.5))
                    Spacer()
                }
                
                HStack {
                    Spacer()
                    // Sign in with Apple
                    SignInWithAppleButton(
                        // Request User FullName and Email
                        onRequest: { request in
                            // You can change them if needed.
                            request.requestedScopes = [.fullName, .email]
                        },
                        // Once user complete, get result
                        onCompletion: { result in
                            // Switch result
                            switch result {
                                // Auth Success
                                case .success(let authResults):

                                switch authResults.credential {
                                    case let appleIDCredential as ASAuthorizationAppleIDCredential:
                                        let userID = appleIDCredential.user
                                        if let firstName = appleIDCredential.fullName?.givenName,
                                            let lastName = appleIDCredential.fullName?.familyName,
                                            let email = appleIDCredential.email{
                                            // For New user to signup, and
                                            // save the 3 records to CloudKit
                                            let record = CKRecord(recordType: "UsersData", recordID: CKRecord.ID(recordName: userID))
                
                                            let username = firstName + "." + lastName + "-" + String(Int.random(in: 1..<100))
                                            record["username"] = username
                                            record["email"] = email
                                            
                                            // Save to local
                                            UserDefaults.standard.set(email, forKey: "email")
                                            UserDefaults.standard.set(username, forKey: "username")
                                            let publicDatabase = CKContainer.default().publicCloudDatabase
                                            publicDatabase.save(record) { (_,_) in
                                                UserDefaults.standard.set(record.recordID.recordName, forKey: "userID")
                                            }
                                            // Change login state
                                            isAuthenticated = true
                                        } else {
                                            // For returning user to signin,
                                            // fetch the saved records from Cloudkit
                                            let publicDatabase = CKContainer.default().publicCloudDatabase
                                            publicDatabase.fetch(withRecordID: CKRecord.ID(recordName: userID)) { (record, error) in
                                                if let fetchedInfo = record {
                                                    let email = fetchedInfo["email"] as? String
                                                    let username = fetchedInfo["username"] as? String
                                                    // Save to local
                                                    UserDefaults.standard.set(userID, forKey: "userID")
                                                    UserDefaults.standard.set(email, forKey: "email")
                                                    UserDefaults.standard.set(username, forKey: "username")
                                                    
                                                    // Change login state
                                                    isAuthenticated = true
                                                }
                                            }
                                        }

                                    // default break (don't remove)
                                    default:
                                        break
                                    }
                                case .failure(let error):
                                    print("failure", error)
                            }
                        }
                    )
                    .signInWithAppleButtonStyle(.whiteOutline) // Button Style
                    .frame(width:200,height:50)         // Set Button Size (Read iOS 14 beta 7 release note)
                    Spacer()
                }
            } //: VSTACK
            .transition(.slide)
            
            Divider()
            
            Button(action: {
                withAnimation {
                    wantsToLogIn = false
                    wantsToSignUp = false
                }
            }, label: {
                Text("Go Back")
                    .font(.system(size: 12, weight: .light, design: .rounded))
                    .foregroundColor(.accentColor)
                    .padding(.vertical, 5)
                    .padding(.horizontal, 20)
            })
        }
    }
}

struct LogInComponent_Previews: PreviewProvider {
    @State static var wantsToLogIn: Bool = false
    @State static var wantsToSignUp: Bool = false
    @State static var signingUpWithEmail: Bool = false
    static var previews: some View {
        LogInComponent(wantsToLogIn: $wantsToLogIn, wantsToSignUp: $wantsToSignUp, signingUpWithEmail: $signingUpWithEmail)
    }
}
