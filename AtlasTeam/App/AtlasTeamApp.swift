//
//  AtlasTeamApp.swift
//  AtlasTeam
//
//  Created by Luke Mason on 1/27/22.
//

import SwiftUI

@main
struct AtlasTeamApp: App {
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
    let persistenceController = PersistenceController.shared
    @AppStorage("isAuthenticated") var isAuthenticated: Bool = false
    @AppStorage("dataLoaded") var dataLoaded: Bool = false

    var body: some Scene {
        WindowGroup {
            if isAuthenticated {
                ContentView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                    .preferredColorScheme(.light)
            }
            else {
                AuthenticationView()
                    .preferredColorScheme(.light)
            }
        }
    }
}
