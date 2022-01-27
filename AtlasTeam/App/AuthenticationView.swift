//
//  AuthenticationView.swift
//  AtlasTeam
//
//  Created by Luke Mason on 1/27/22.
//

import SwiftUI

struct AuthenticationView: View {
    @State var wantsToLogIn: Bool = false
    @State var wantsToSignUp: Bool = false
    @State var isSigningInWithEmail: Bool = false
    @State var timer: Timer? = nil
    @State var count: Int = 0
    
    var body: some View {
        VStack {
            Spacer()
            if !wantsToSignUp && !isSigningInWithEmail {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .transition(.offset(x: 0, y: -600))
            }
            if wantsToLogIn || wantsToSignUp {
                if wantsToLogIn {
                    if isSigningInWithEmail {
                        EmailSignInComponent(wantsToLogIn: $wantsToLogIn, wantsToSignUp: $wantsToSignUp, isSigningUpWithEmail: $isSigningInWithEmail)
                            .transition(.offset(x: 0, y: 600))
                    }
                    else {
                        LogInComponent(wantsToLogIn: $wantsToLogIn, wantsToSignUp: $wantsToSignUp, signingUpWithEmail: $isSigningInWithEmail)
                            .transition(.slide)
                    }
                }
                else {
                    SignUpComponent(wantsToLogIn: $wantsToLogIn, wantsToSignUp: $wantsToSignUp)
                        .transition(.offset(x: 0, y: 600))
                }
            } //: CONDITIONAL
            else {
                HStack {
                    Spacer()
                    VStack {
                        Button(action: {
                            withAnimation {
                                wantsToLogIn = true
                            }
                        }, label: {
                            Text("Log In")
                                .font(.system(size: 24, weight: .light, design: .rounded))
                                .foregroundColor(Color.accentColor)
                                .padding(.vertical, 5)
                                .padding(.horizontal, 30)
                                .background(Capsule().stroke(Color.accentColor, lineWidth: 2))
                        })
                        Button(action: {
                            withAnimation(.easeIn(duration: 0.5)) {
                                wantsToSignUp = true
                            }
                            
                        }, label: {
                            Text("Sign Up")
                                .font(.system(size: 24, weight: .light, design: .rounded))
                                .foregroundColor(Color("Blue"))
                                .padding(.vertical, 5)
                                .padding(.horizontal, 20)
                                .background(Capsule().stroke(Color("Blue"), lineWidth: 2))
                        })
                    }
                    Spacer()
                } //: HSTACK
                .frame(height: 50)
                .transition(.slide)
                .padding(.top, 10)
            } //: CONDITIONAL
            Spacer()
        } //: VSTACK
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView()
    }
}
