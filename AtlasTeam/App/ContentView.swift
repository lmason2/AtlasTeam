//
//  ContentView.swift
//  AtlasTeam
//
//  Created by Luke Mason on 1/27/22.
//

import SwiftUI
import CoreData
import CloudKit

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    @State var titleOffset: CGFloat = -15
    @State var underlineHeight: CGFloat = 0
    @Binding var dataLoaded: Bool
    @State var myTeam: Team?
    
    @AppStorage("isAuthenticated") var isAuthenticated: Bool = false
    @AppStorage("team") var team: String = ""
    
    func getTeam() {
        let publicDatabase = CKContainer.default().publicCloudDatabase
        publicDatabase.fetch(withRecordID: CKRecord.ID(recordName: team)) { (fetched, error) in
            guard let teamRecord = fetched else {
                print("Error")
                return
            }
            let coach = teamRecord.value(forKey: "coach") as! CKRecord.Reference
            let name = teamRecord.value(forKey: "name") as! String
//            myTeam.location = teamRecord.value(forKey: "location") as! CLLocation
            let assistants = teamRecord.value(forKey: "assistantCoaches") as? [CKRecord.Reference] ?? []
            let trainers = teamRecord.value(forKey: "trainers") as? [CKRecord.Reference] ?? []
            let athletes = teamRecord.value(forKey: "athletes") as? [CKRecord.Reference] ?? []
            let primaryString = teamRecord.value(forKey: "primaryColor") as! String
            let secondaryString = teamRecord.value(forKey: "secondaryColor") as! String
            
            myTeam = Team(assistantCoaches: assistants, athletes: athletes, coach: coach, location: CLLocation(), name: name, password: "", trainers: trainers, primaryString: primaryString, secondaryString: secondaryString)
            
            dataLoaded = true
        }
    }
    
    func logoutProcess() {
        UserDefaults.standard.set(nil, forKey: "team")
        UserDefaults.standard.set(nil, forKey: "username")
        UserDefaults.standard.set(nil, forKey: "email")
        UserDefaults.standard.set(nil, forKey: "userID")
    }

    var body: some View {
        NavigationView {
            if team == "" {
                ZStack {
                    VStack {
                        Spacer()
                        Text("AtlasTeam")
                            .foregroundColor(Color.accentColor)
                            .font(.system(size: 64, weight: .semibold, design: .rounded))
                            .background(
                                Color.black
                                    .frame(height: underlineHeight)
                                    .offset(x: 0, y: 30)
                            )
                            .offset(x: 0, y: titleOffset)
                        
                        NavigationLink(destination: CreateTeamView(), label: {
                            HStack {
                                Image(systemName: "plus.circle")
                                Text("Create Team")
                                    .foregroundColor(Color.black)
                                    .font(.system(size: 16, weight: .medium, design: .rounded))
                            }
                            .frame(width: 150, height: 40)
                            .background(RoundedRectangle(cornerRadius: 5).stroke(Color.black, lineWidth: 3))
                            
                        })
                        
                        NavigationLink(destination: JoinTeamView(), label: {
                            HStack {
                                Image(systemName: "person.3")
                                    .foregroundColor(Color.accentColor)
                                Text("Join Team")
                                    .foregroundColor(Color.black)
                                    .font(.system(size: 16, weight: .medium, design: .rounded))
                            }
                            .frame(width: 150, height: 40)
                            .background(RoundedRectangle(cornerRadius: 5).stroke(Color.black, lineWidth: 3))
                            
                        })
                        
                        Button(action: {
                            isAuthenticated = false
                        }, label: {
                            Text("Logout")
                                .foregroundColor(Color("Blue"))
                                .font(.system(size: 16, weight: .medium, design: .rounded))
                                .frame(width: 150, height: 40)
                                .background(RoundedRectangle(cornerRadius: 5).stroke(Color("Blue"), lineWidth: 3))
                        })
                        Spacer()
                    }
                    
                    VStack {
                        Spacer()
                        HStack {
                            Text("Not looking for a team?").foregroundColor(Color.gray)
                            Spacer()
                            Link("AtlasLog", destination: URL(string: "https://apps.apple.com/us/app/atlaslog/id1606260069")!)
                            Image(systemName: "arrow.up.right.square").foregroundColor(.black)
                        } //: HSTACK
                    } //: VSTACK
                } //: ZSTACK
                .padding()
                .navigationBarHidden(true)
            }
            else {
                if dataLoaded {
                    MyAtlasView(myTeam: myTeam!)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button(action: {
                                isAuthenticated = false
                                logoutProcess()
                            }) {
                                Image("logo")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30, height: 30)
                            }
                        }
                    } //: TOOLBAR
                }
                else {
                    ProgressView("Loading Team…")
                        .onAppear {
                            getTeam()
                        }
                }
            } //: CONDITIONAL
        } //: NAVIGATION
        .onAppear {
            withAnimation(.easeIn(duration: 1)) {
                titleOffset = 25
                underlineHeight = 5
            }
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()
