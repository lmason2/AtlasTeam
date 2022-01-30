//
//  TrainingDetailView.swift
//  AtlasTeam
//
//  Created by Luke Mason on 1/29/22.
//

import SwiftUI

struct TrainingDetailView: View {
    let training: Training
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
                                Text(training.info ?? "None")
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
        }
        .padding(.top, 20)
        .padding(.horizontal, 5)
        .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.85)
        .background(getGradient(training.type))
        .cornerRadius(10)
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct TrainingDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TrainingDetailView(training: Training(date: Date(), type: .easy, mileage: 10.0, minutes: nil, rating: 8, info: ""))
    }
}
