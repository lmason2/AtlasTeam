//
//  AtlasTeamApp.swift
//  AtlasTeam
//
//  Created by Luke Mason on 1/27/22.
//

import SwiftUI

@main
struct AtlasTeamApp: App {
    let persistenceController = PersistenceController.shared
    @AppStorage("isAuthenticated") var isAuthenticated: Bool = false
    @AppStorage("dataLoaded") var dataLoaded: Bool = false

    var body: some Scene {
        WindowGroup {
            if isAuthenticated {
                ContentView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
            else {
                AuthenticationView()
            }
        }
    }
}
