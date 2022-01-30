//
//  NewTrainingSheetView.swift
//  AtlasTeam
//
//  Created by Luke Mason on 1/29/22.
//

import SwiftUI
import CloudKit

struct NewTrainingSheetView: View {
    let primaryColor: Color
    let secondaryColor: Color
    @State var trainingType: TrainingType
    @State var mileage: String = ""
    @State var minutes: String = ""
    @State var raceDistance: String = ""
    @State var raceTime: String = ""
    @State var additionalInfo: String
    @State private var rating = 5.0
    @State private var isEditing = false
    @State var date: Date = Date()
    @State var showAlert: Bool = false
    @FocusState var fieldIsFocused: Bool
    @FocusState var additionalInfoIsFocused: Bool
    let userID = UserDefaults.standard.string(forKey: "userID")
    @Binding var myTrainingLoaded: Bool
    @Binding var displayingThisSheet: Bool
    @Binding var myTrainings: [Training]
    
    func submitTraining() {
        guard let unwrappedMileage = Double(mileage), unwrappedMileage != 0 else {
            showAlert = true
            return
        }
        let record = CKRecord(recordType: "Training", recordID: CKRecord.ID())
        record["date"] = date
        record["additionalInfo"] = additionalInfo
        record["mileage"] = unwrappedMileage
        if minutes != "" && Double(minutes) != nil {
            record["minutes"] = Double(minutes)
        }
        record["rating"] = Int(rating)
        record["type"] = getTrainingTypeString(trainingType)

        let publicDatabase = CKContainer.default().publicCloudDatabase
        publicDatabase.save(record) { recordResult, error in
            if error == nil {
                publicDatabase.fetch(withRecordID: CKRecord.ID(recordName: userID!)) { (fetched, error) in
                    guard let selfRecord = fetched else {
                        print("returning")
                        return
                    }
                    
                    if var currentTrainings = selfRecord.value(forKey: "activities") as? [CKRecord.Reference] {
                        currentTrainings.append(CKRecord.Reference(record: recordResult!, action: .none))
                        selfRecord["activities"] = currentTrainings
                        publicDatabase.save(selfRecord) { record, error in
                            if let error = error {
                                print(error)
                            }
                            else {
                                let training = Training(date: date, type: trainingType, mileage: unwrappedMileage, minutes: Double(minutes), rating: Int(rating), info: additionalInfo)
                                myTrainings = []
                                myTrainingLoaded = false
                                displayingThisSheet = false
                            }
                        }
                    }
                    else {
                        let trainingsRecords = [CKRecord.Reference(record: recordResult!, action: .none)]
                        selfRecord["activities"] = trainingsRecords
                        publicDatabase.save(selfRecord) { record, error in
                            if let error = error {
                                print(error)
                            }
                            else {
                                let training = Training(date: date, type: trainingType, mileage: unwrappedMileage, minutes: Double(minutes), rating: Int(rating), info: additionalInfo)
                                myTrainings = []
                                myTrainingLoaded = false
                                displayingThisSheet = false
                            }
                        }
                    }
                }
            }
            else {
                print("error")
                print("here")
                print(error)
            }
        } //: SAVE NEW TEAM
    }
    var body: some View {
        VStack {
            Text("New Training")
                .font(.system(size: 32, weight: .semibold, design: .rounded))
                .padding(.top, 20)
            Divider()
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    if !additionalInfoIsFocused {
                        VStack {
                            DatePicker(
                                "Training Date",
                                selection: $date,
                                displayedComponents: [.date]
                            )
                            .padding(.horizontal)
                            .font(.system(size: 18, weight: .semibold, design: .rounded))
                            HStack {
                                VStack {
                                    HStack {
                                        Spacer()
                                        Text("Training Type")
                                            .font(.system(size: 18, weight: .semibold, design: .rounded))
                                        Spacer()
                                    }
                                    .padding(.horizontal, 10)
                                    
                                    Divider()
                                    
                                    HStack {
                                        Text("Easy")
                                            .font(.system(size: 14, weight: .medium, design: .rounded))
                                        Button(action: {
                                            feedback.notificationOccurred(.success)
                                            withAnimation {
                                                trainingType = .easy
                                            }
                                        }, label: {
                                            Image(systemName: trainingType == .easy ? "circle.fill" : "circle")
                                                .foregroundColor(Color.blue)
                                        })
                                        Spacer()
                                    }
                                    .padding(.horizontal, 10)
                                    
                                    HStack {
                                        Text("Workout")
                                            .font(.system(size: 14, weight: .medium, design: .rounded))
                                        Button(action: {
                                            feedback.notificationOccurred(.success)
                                            withAnimation {
                                                trainingType = .workout
                                            }
                                        }, label: {
                                            Image(systemName: trainingType == .workout ? "circle.fill" : "circle")
                                                .foregroundColor(Color.red)
                                        })
                                        Spacer()
                                    }
                                    .padding(.horizontal, 10)
                                    
                                    HStack {
                                        Text("Medium Long Run")
                                            .font(.system(size: 14, weight: .medium, design: .rounded))
                                        Button(action: {
                                            feedback.notificationOccurred(.success)
                                            withAnimation {
                                                trainingType = .mediumLong
                                            }
                                        }, label: {
                                            Image(systemName: trainingType == .mediumLong ? "circle.fill" : "circle")
                                                .foregroundColor(Color.mint)
                                        })
                                        Spacer()
                                    }
                                    .padding(.horizontal, 10)
                                    
                                    HStack {
                                        Text("Long Run")
                                            .font(.system(size: 14, weight: .medium, design: .rounded))
                                        Button(action: {
                                            feedback.notificationOccurred(.success)
                                            withAnimation {
                                                trainingType = .long
                                            }
                                        }, label: {
                                            Image(systemName: trainingType == .long ? "circle.fill" : "circle")
                                                .foregroundColor(Color.purple)
                                        })
                                        Spacer()
                                    }
                                    .padding(.horizontal, 10)
                                    
                                    HStack {
                                        Text("Race")
                                            .font(.system(size: 14, weight: .medium, design: .rounded))
                                        Button(action: {
                                            feedback.notificationOccurred(.success)
                                            withAnimation {
                                                trainingType = .race
                                            }
                                        }, label: {
                                            Image(systemName: trainingType == .race ? "circle.fill" : "circle")
                                                .foregroundColor(Color.yellow)
                                        })
                                        Spacer()
                                    }
                                    .padding(.horizontal, 10)
                                    .padding(.bottom, 5)
                                    
                                } //: TRAINING TYPE VSTACK
                                .frame(width: UIScreen.main.bounds.width * 0.50, height: 175)
                                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.white, lineWidth: 3))
                                
                                VStack {
                                    HStack {
                                        Spacer()
                                        Text("Metrics")
                                            .font(.system(size: 18, weight: .semibold, design: .rounded))
                                        Spacer()
                                    }
                                    .padding(.top, 16)
                                    .padding(.horizontal, 10)
                                    
                                    Divider()
                                    
                                    TextField(
                                        "Mileage",
                                        text: $mileage
                                    )
                                    .keyboardType(.decimalPad)
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 10)
                                    .focused($fieldIsFocused)
                                    
                                    Divider()
                                    TextField(
                                        "Minutes",
                                        text: $minutes
                                    )
                                    .keyboardType(.numberPad)
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 10)
                                    .focused($fieldIsFocused)
                                    
                                    Spacer()
                                }
                                .frame(width: UIScreen.main.bounds.width * 0.30, height: 175)
                                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.white, lineWidth: 3))
                            }
                            .padding(.top, 10)
                            Slider(
                                value: $rating,
                                in: 0...10,
                                step: 1
                            ) {
                                Text("Rating")
                            } minimumValueLabel: {
                                Text("0")
                            } maximumValueLabel: {
                                Text("10")
                            } onEditingChanged: { editing in
                                isEditing = editing
                            }
                            .tint(Color.black)
                            .padding(.horizontal, 5)
                            Text("Rating: \(Int(rating))")
                                .font(.system(size: 16, weight: .semibold, design: .rounded))
                            
                            if trainingType == .race {
                                VStack {
                                    HStack {
                                        Spacer()
                                        Text("Race Info")
                                            .font(.system(size: 18, weight: .semibold, design: .rounded))
                                            .padding(.top, 20)
                                        Spacer()
                                    }
                                    Divider()
                                    TextField(
                                        "Race Distance",
                                        text: $raceDistance
                                    )
                                    .padding()
                                    .focused($fieldIsFocused)
                                    
                                    Divider()
                                    TextField (
                                        "Race Time",
                                        text: $raceTime
                                    )
                                    .padding()
                                    .padding(.bottom, 15)
                                    .focused($fieldIsFocused)
                                }
                                .transition(.slide)
                                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.white, lineWidth: 3))
                                .padding(.horizontal, 10)
                                .padding(.vertical, 5)
                            }
                        }
                        .transition(.slide)
                    }
                    
                    VStack {
                        HStack {
                            Spacer()
                            Text("Additional Info")
                                .font(.system(size: 18, weight: .semibold, design: .rounded))
                                .padding(.top, 20)
                            Spacer()
                        }
                        Divider()
                        TextEditor(text: $additionalInfo)
                            .foregroundColor(.black)
                            .background(Color.white)
                            .cornerRadius(10)
                            .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
                            .frame(minHeight: 100)
                            .focused($additionalInfoIsFocused)
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                }
            }
            .padding(.horizontal, 5)
            .frame(width: UIScreen.main.bounds.width * 0.9)
            
            Divider()
            HStack {
                Button(action: {
                    submitTraining()
                }, label: {
                    Text("Save")
                        .foregroundColor(Color.black)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 20)
                })
                .background(Capsule().stroke(Color.black, lineWidth: 3))
                .padding(.vertical, 10)
                
                Button(action: {
                    withAnimation {
                        fieldIsFocused = false
                        additionalInfoIsFocused = false
                    }
                }, label: {
                    Text("Dismiss Keyboard")
                        .foregroundColor((fieldIsFocused || additionalInfoIsFocused) ? Color.black : Color.gray)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 20)
                })
                .disabled(!(fieldIsFocused || additionalInfoIsFocused))
                .background(Capsule().stroke((fieldIsFocused || additionalInfoIsFocused) ? Color.black : Color.gray, lineWidth: 3))
                .padding(.vertical, 10)
            }
        }
        .alert("Please check mileage", isPresented: $showAlert) {
            Button("OK", role: .cancel) { }
        }
        .cornerRadius(10)
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }
}
