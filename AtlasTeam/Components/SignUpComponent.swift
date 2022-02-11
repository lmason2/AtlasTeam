//
//  SignUpComponent.swift
//  AtlasTeam
//
//  Created by Luke Mason on 1/27/22.
//

import SwiftUI
import CloudKit

struct SignUpComponent: View {
    // MARK: - PROPERTIES
    @AppStorage("isAuthenticated") var isAuthenticated: Bool = false
    @Binding var wantsToLogIn: Bool
    @Binding var wantsToSignUp: Bool
    @State var username: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var confirmPassword: String = ""
    @State var imageOffset: CGFloat = 0
    @State var timer: Timer? = nil
    @State var createdAccount: Bool = false
    @State var transitioning: Bool = false
    @State var showAlert: Bool = false
    @State var message: String = ""
    
    // MARK: - FUNCTIONS
    func validate() {
        let record = CKRecord(recordType: "UsersData", recordID: CKRecord.ID())

        if username != "" && email != "" && password != "" && confirmPassword != "" {
            if confirmPassword == password {
                let publicDatabase = CKContainer.default().publicCloudDatabase
                let predicate = NSPredicate(format: "username == %@", username)
                let query = CKQuery(recordType: "UsersData", predicate: predicate)
                publicDatabase.perform(query, inZoneWith: nil) {results, error in
                    if results == [] {
                        let predicate = NSPredicate(format: "email == %@", email)
                        let query = CKQuery(recordType: "UsersData", predicate: predicate)
                        publicDatabase.perform(query, inZoneWith: nil) {results, error in
                            if results == [] {
                                record["username"] = username
                                record["email"] = email
                                record["password"] = password
                                // Save to local
                                UserDefaults.standard.set(email, forKey: "email")
                                UserDefaults.standard.set(username, forKey: "username")
                                UserDefaults.standard.set("", forKey: "team")
                                let publicDatabase = CKContainer.default().publicCloudDatabase
                                publicDatabase.save(record) { recordResult, error in
                                    if error == nil {
                                        UserDefaults.standard.set(record.recordID.recordName, forKey: "userID")
                                        withAnimation(.easeIn(duration: 0.5)) {
                                            imageOffset = -600
                                            createdAccount = true
                                        }
                                        var count = 0
                                        if timer != nil {
                                            timer?.invalidate()
                                        }
                                        DispatchQueue.main.async { [self] in
                                            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                                                count += 1
                                                if count == 1 {
                                                    withAnimation(.easeOut(duration: 1)) {
                                                        transitioning = true
                                                    }
                                                }
                                                if count == 2 {
                                                    isAuthenticated = true
                                                }
                                            }
                                        }
                                    }
                                    else {
                                        print(error ?? "")
                                    }
                                }
                            }
                            else {
                                message = "Email already in use"
                                showAlert = true
                            }
                        }
                    }
                    else {
                        message = "Username already exists"
                        showAlert = true
                    }
                }
            }
            else {
                message = "Passwords don't match"
                showAlert = true
            }
        }
        else {
            message = "Fill all fields"
            showAlert = true
        }
    }
    
    // MARK: - BODY
    var body: some View {
        VStack(spacing: 15) {
            HStack {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .offset(x: 0, y: imageOffset)
                if !transitioning {
                    Text("Welcome")
                        .foregroundColor(Color.accentColor)
                        .font(.system(size: 48, weight: .ultraLight, design: .rounded))
                        .transition(.opacity)
                }
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .offset(x: 0, y: imageOffset)
            }
            
            if !createdAccount {
                VStack {
                    Divider()
                    
                    // Fields
                    SignUpFieldComponent(isSecure: false, textBinding: $username, textPreview: "Username", keyboardType: .default)
                    SignUpFieldComponent(isSecure: false, textBinding: $email, textPreview: "Email", keyboardType: .emailAddress)
                    SignUpFieldComponent(isSecure: true, textBinding: $password, textPreview: "Password", keyboardType: .default)
                    SignUpFieldComponent(isSecure: true, textBinding: $confirmPassword, textPreview: "Confirm Password", keyboardType: .default)
                    
                    // New Account Button
                    Button(action: {
                        validate()
                    }, label: {
                        Text("Create Account")
                            .font(.system(size: 18, weight: .light, design: .rounded))
                            .foregroundColor(.accentColor)
                            .padding(.vertical, 5)
                            .padding(.horizontal, 20)
                    })
                    .background(Capsule().stroke(Color.accentColor, lineWidth: 2))
                    
                    // Go Back Button
                    Button(action: {
                        withAnimation(.easeIn(duration: 0.5)) {
                            wantsToSignUp = false
                            wantsToLogIn = false
                        }
                    }, label: {
                        Text("Already have an account? Go back")
                            .font(.system(size: 12, weight: .light, design: .rounded))
                            .foregroundColor(.accentColor)
                            .padding(.vertical, 5)
                            .padding(.horizontal, 20)
                    })
                } //: VSTACK
                .transition(.offset(x: 0, y: 600))
            } //: CONDITIONAL
        } //: VSTACK
        .alert(message, isPresented: $showAlert) {
            Button("Ok", role: .cancel) {}
        }
    }
}

struct SignUpComponent_Previews: PreviewProvider {
    @State static var wantsToLogIn: Bool = false
    @State static var wantsToSignUp: Bool = false
    static var previews: some View {
        SignUpComponent(wantsToLogIn: $wantsToLogIn, wantsToSignUp: $wantsToSignUp)
    }
}
