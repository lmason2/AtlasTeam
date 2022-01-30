//
//  NewTrainingSheetView.swift
//  AtlasTeam
//
//  Created by Luke Mason on 1/29/22.
//

import SwiftUI

struct NewTrainingSheetView: View {
    let primaryColor: Color
    let secondaryColor: Color
    @State var trainingType: TrainingType
    @State var mileage: String = ""
    @State var minutes: String = ""
    @State var raceDistance: String = ""
    @State var raceTime: String = ""
    @State var additionalInfo: String
    @FocusState var mileageIsFocused: Bool
    @FocusState var minutesIsFocused: Bool
    @FocusState var additionalInfoIsFocused: Bool
    @State private var rating = 5.0
    @State private var isEditing = false
    
    var body: some View {
        VStack {
            Text("New Training")
                .font(.system(size: 32, weight: .semibold, design: .rounded))
                .padding(.top, 20)
            Divider()
            
            ScrollView(.vertical, showsIndicators: false) {
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
                        .focused($mileageIsFocused)
                        
                        Divider()
                        TextField(
                            "Minutes",
                            text: $minutes
                        )
                        .keyboardType(.numberPad)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 10)
                        .focused($minutesIsFocused)
                        
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
                        Divider()
                        TextField (
                            "Race Time",
                            text: $raceTime
                        )
                        .padding()
                        .padding(.bottom, 15)
                    }
                    .transition(.slide)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.white, lineWidth: 3))
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
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
            .offset(y: additionalInfoIsFocused ? -100 : 0)
            .padding(.horizontal, 5)
            .frame(width: UIScreen.main.bounds.width * 0.9)
            
            Divider()
            Button(action: {
                print("Saving")
            }, label: {
                Text("Save")
                    .foregroundColor(Color.black)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 20)
            })
            .background(Capsule().stroke(Color.black, lineWidth: 3))
            .padding(.vertical, 10)
        }
        .cornerRadius(10)
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .onTapGesture {
            mileageIsFocused = false
            minutesIsFocused = false
            additionalInfoIsFocused = false
        }
    }
}

struct NewTrainingSheetView_Previews: PreviewProvider {
    static var previews: some View {
        NewTrainingSheetView(primaryColor: Color("Blue"), secondaryColor: Color.red, trainingType: .easy, additionalInfo: "")
    }
}
