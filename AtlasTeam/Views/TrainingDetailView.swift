//
//  TrainingDetailView.swift
//  AtlasTeam
//
//  Created by Luke Mason on 1/29/22.
//

import SwiftUI
import CloudKit

struct TrainingDetailView: View {
    // MARK: - PROPERTIES
    let training: Training
    let myTeam: Team
    @State var editSheetShown: Bool = false
    @State var coachesView: Bool = true
    @Binding var myTrainingLoaded: Bool
    let userID = UserDefaults.standard.string(forKey: "userID")
    
    // MARK: - FUNCTIONS
    func DeleteActivity() {
        let publicDatabase = CKContainer.default().publicCloudDatabase
        publicDatabase.delete(withRecordID: training.name.recordID) { (id, error) in
            if id != nil {
                publicDatabase.fetch(withRecordID: CKRecord.ID(recordName: userID!)) { (fetched, error) in
                    if let selfRecord = fetched {
                        let currentActivities = selfRecord["activities"] as? [CKRecord.Reference] ?? []
                        let updatedActivities = currentActivities.filter { $0 != training.name }
                        selfRecord["activities"] = updatedActivities
                        publicDatabase.save(selfRecord) { record, error in
                            if let error = error {
                                print(error)
                            }
                            else {
                                print("successfully removed activity from self")
                                myTrainingLoaded = false
                            }
                        }
                    }
                }
            }
            if error != nil {
                print(error!)
            }
        }
    }
    
    // MARK: - BODY
    var body: some View {
        VStack {
            Text("\(training.date, formatter: trainingDetailDateFormatter)")
                .font(.system(size: 32, weight: .semibold, design: .rounded))
                .multilineTextAlignment(.center)
            Divider()
            HStack {
                Text(getTrainingTypeString(training.type))
                    .font(.system(size: 24, weight: .semibold, design: .rounded))
                Text("-")
                    .font(.system(size: 24, weight: .semibold, design: .rounded))
                Text("\(training.rating)/10")
                    .font(.system(size: 24, weight: .semibold, design: .rounded))
            }
            
            Divider()
            ScrollView(.vertical) {
                HStack {
                    VStack(spacing: 0){
                        Text("Minutes")
                            .foregroundColor(.black)
                            .font(.system(size: 17, weight: .semibold, design: .rounded))
                        Group {
                            HStack {
                                Text(training.minutesString)
                                    .font(.system(size: 15, weight: .semibold, design: .rounded))
                            }
                            .padding()
                        }
                        .border(.white, width: 2)
                        .cornerRadius(5)
                        .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
                    }
                    Divider()
                    VStack(spacing: 0){
                        Text("Mileage")
                            .foregroundColor(.black)
                            .font(.system(size: 17, weight: .semibold, design: .rounded))
                        Group {
                            HStack {
                                Text(training.mileageString)
                                    .font(.system(size: 15, weight: .semibold, design: .rounded))
                            }
                            .padding()
                        }
                        .border(.white, width: 2)
                        .cornerRadius(5)
                        .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
                    }
                    Divider()
                    VStack(spacing: 0){
                        Text("Pace")
                            .foregroundColor(.black)
                            .font(.system(size: 17, weight: .semibold, design: .rounded))
                        Group {
                            HStack {
                                Text(training.paceString)
                                    .font(.system(size: 15, weight: .semibold, design: .rounded))
                            }
                            .padding()
                        }
                        .border(.white, width: 2)
                        .cornerRadius(5)
                        .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
                    }
                }
               
                Divider()
                
                if training.type == .race {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Race Information")
                            .foregroundColor(.black)
                            .font(.system(size: 17, weight: .semibold, design: .rounded))
                            .padding(.horizontal, 7)
                        
                        Group {
                            HStack {
                                VStack {
                                    HStack (spacing: 5) {
                                        Text("Race Distance: ")
                                            .font(.system(size: 15, weight: .semibold, design: .rounded))
//                                        Text(training.raceDistance ?? "None")
//                                            .font(.system(size: 15, weight: .semibold, design: .rounded))
                                        Text("None")
                                            .font(.system(size: 15, weight: .semibold, design: .rounded))
                                        Spacer()
                                    }
                                    HStack (spacing: 0) {
                                        Text("Time: ")
                                            .font(.system(size: 15, weight: .semibold, design: .rounded))
                                            .padding(.trailing, 3)
                                        if true {
//                                        if training.raceHours != 0 {
//                                            Text("\(training.raceHours)")
//                                                .font(.system(size: 15, weight: .semibold, design: .rounded))
                                            Text(":")
                                                .font(.system(size: 15, weight: .semibold, design: .rounded))
                                        }
//                                        Text("\(training.raceMinutes)")
//                                            .font(.system(size: 15, weight: .semibold, design: .rounded))
                                        Text(":")
                                            .font(.system(size: 15, weight: .semibold, design: .rounded))
//                                        Text("\(training.raceSeconds)")
//                                            .font(.system(size: 15, weight: .semibold, design: .rounded))
                                        Spacer()
                                    }
                                }
                                Spacer()
                            }
                            .padding()
                        }
                        .shadow(color: Color.black.opacity(0.15), radius: 5)
                        .border(.white, width: 2)
                        .cornerRadius(5)
                        .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
                    }
                    Divider()
                }
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("Additional Info")
                        .foregroundColor(.black)
                        .font(.system(size: 17, weight: .semibold, design: .rounded))
                        .padding(.horizontal, 7)
                    Group {
                        HStack {
                            VStack {
                                Text(training.info)
                                    .font(.system(size: 15, weight: .semibold, design: .rounded))
                            }
                            Spacer()
                        }
                        .padding()
                    }
                    .border(.white, width: 2)
                    .cornerRadius(5)
                    .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
                }
            }
            Spacer()
            if !coachesView {
                HStack {
                    Spacer()
                    Button(action: {
                        DeleteActivity()
                    }, label: {
                        Image(systemName: "trash.circle")
                            .foregroundColor(Color.white)
                            .font(.system(size: 32))
                    })
//                    Spacer()
//                    Button(action: {
//                        editSheetShown = true
//                    }, label: {
//                        Image(systemName: "pencil.circle")
//                            .foregroundColor(Color.white)
//                            .font(.system(size: 32))
//                    })
                    Spacer()
                }
                .padding(.bottom, 10)
                .padding(.horizontal, 10)
            }
        }
        .padding(.top, 20)
        .padding(.horizontal, 5)
        .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.85)
        .background(getGradient(training.type))
        .cornerRadius(10)
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $editSheetShown) {
            EditTrainingSheetView()
        }
    }
}
