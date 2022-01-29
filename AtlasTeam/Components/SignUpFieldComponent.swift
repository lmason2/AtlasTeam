//
//  SignUpFieldComponent.swift
//  AtlasTeam
//
//  Created by Luke Mason on 1/28/22.
//

import SwiftUI

struct SignUpFieldComponent: View {
    // MARK: - PROPERTIES
    let isSecure: Bool
    @Binding var textBinding: String
    let textPreview: String
    let keyboardType: UIKeyboardType
    var body: some View {
        if !isSecure {
            TextField(
                textPreview,
                text: $textBinding
            )
            .foregroundColor(Color.accentColor)
            .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
            .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color("Blue"), lineWidth: 3))
            .textInputAutocapitalization(.never)
            .disableAutocorrection(true)
            .padding(.horizontal, 20)
            .keyboardType(keyboardType)
        }
        else {
            SecureField(
                textPreview,
                text: $textBinding
            )
            .foregroundColor(Color.accentColor)
            .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
            .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color("Blue"), lineWidth: 3))
            .textInputAutocapitalization(.never)
            .disableAutocorrection(true)
            .padding(.horizontal, 20)
            .keyboardType(keyboardType)
        }
    }
}

struct SignUpFieldComponent_Previews: PreviewProvider {
    @State static var textBinding: String = ""
    static var previews: some View {
        SignUpFieldComponent(isSecure: false, textBinding: $textBinding, textPreview: "", keyboardType: .emailAddress)
    }
}
