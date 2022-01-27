//
//  LogInComponent.swift
//  AtlasTeam
//
//  Created by Luke Mason on 1/27/22.
//

import SwiftUI

struct LogInComponent: View {
    @Binding var wantsToLogIn: Bool
    @Binding var wantsToSignUp: Bool
    @Binding var signingUpWithEmail: Bool
    
    var body: some View {
        VStack {
            HStack{
                Spacer()
                Button(action: {
                    withAnimation(.easeIn(duration: 0.5)) {
                        signingUpWithEmail = true
                    }
                }, label: {
                    Text("Email")
                        .font(.system(size: 24, weight: .light, design: .rounded))
                        .foregroundColor(.accentColor)
                        .padding(.vertical, 5)
                        .padding(.horizontal, 20)
                })
                .background(Capsule().stroke(Color.accentColor, lineWidth: 2))
                Divider()
                Button(action: {
                }, label: {
                    Text("Apple")
                        .font(.system(size: 24, weight: .light, design: .rounded))
                        .foregroundColor(Color("Blue"))
                        .padding(.vertical, 5)
                        .padding(.horizontal, 20)
                })
                .background(Capsule().stroke(Color("Blue"), lineWidth: 2))
                Spacer()
            } //: HSTACK
            .frame(height: 50)
            .transition(.slide)
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
