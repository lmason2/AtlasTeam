//
//  MyAtlasView.swift
//  AtlasTeam
//
//  Created by Luke Mason on 1/28/22.
//

import SwiftUI

struct MyAtlasView: View {
    let userID = UserDefaults.standard.string(forKey: "userID")
    let email = UserDefaults.standard.string(forKey: "email")
    let username = UserDefaults.standard.string(forKey: "username")
    let team = UserDefaults.standard.string(forKey: "team")
    var body: some View {
        VStack {
            Text(username!)
            Text(email!)
            Text(userID!)
            Text(team!)
        } //: VSTACK
    }
}

struct MyAtlasView_Previews: PreviewProvider {
    static var previews: some View {
        MyAtlasView()
    }
}
