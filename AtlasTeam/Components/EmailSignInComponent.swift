//
//  EmailSignInComponent.swift
//  AtlasTeam
//
//  Created by Luke Mason on 1/27/22.
//

import SwiftUI

struct EmailSignInComponent: View {
    // MARK: - PROPERTIES
    @AppStorage("isAuthenticated") var isAuthenticated: Bool = false
    @Binding var wantsToLogIn: Bool
    @Binding var wantsToSignUp: Bool
    @Binding var isSigningUpWithEmail: Bool
    @State var username: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var confirmPassword: String = ""
    @State var imageOffset: CGFloat = 0
    @State var timer: Timer? = nil
    @State var createdAccount: Bool = false
    @State var transitioning: Bool = false
    
    func validate() {
        isAuthenticated = true
    }
    
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
                    
                    TextField(
                        "Email",
                        text: $email
                    )
                    .foregroundColor(Color.accentColor)
                    .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color("Blue"), lineWidth: 3))
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .padding(.horizontal, 20)
                    
                    TextField(
                        "Password",
                        text: $password
                    )
                    .foregroundColor(Color.accentColor)
                    .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color("Blue"), lineWidth: 3))
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .padding(.horizontal, 20)
                    
                    Button(action: {
                        withAnimation(.easeIn(duration: 0.5)) {
                            imageOffset = -600
                            createdAccount = true
                        }
                        var count = 0
                        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                            count += 1
                            if count == 1 {
                                withAnimation(.easeOut(duration: 1)) {
                                    transitioning = true
                                }
                            }
                            if count == 2 {
                                validate()
                            }
                        }
                    }, label: {
                        Text("Log In")
                            .font(.system(size: 18, weight: .light, design: .rounded))
                            .foregroundColor(.accentColor)
                            .padding(.vertical, 5)
                            .padding(.horizontal, 20)
                    })
                    .background(Capsule().stroke(Color.accentColor, lineWidth: 2))
                    
                    Button(action: {
                        withAnimation(.easeIn(duration: 0.5)) {
                            wantsToSignUp = false
                            isSigningUpWithEmail = false
                            wantsToLogIn = true
                        }
                    }, label: {
                        Text("Go back")
                            .font(.system(size: 12, weight: .light, design: .rounded))
                            .foregroundColor(.accentColor)
                            .padding(.vertical, 5)
                            .padding(.horizontal, 20)
                    })
                } //: VSTACK
                .transition(.offset(x: 0, y: 600))
            } //: CONDITIONAL
        }
    }
}

struct EmailSignInComponent_Previews: PreviewProvider {
    @State static var wantsToLogIn: Bool = false
    @State static var wantsToSignUp: Bool = false
    @State static var email: Bool = false
    static var previews: some View {
        EmailSignInComponent(wantsToLogIn: $wantsToLogIn, wantsToSignUp: $wantsToSignUp, isSigningUpWithEmail: $email)
    }
}
