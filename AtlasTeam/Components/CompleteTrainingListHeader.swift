//
//  CompleteTrainingListHeader.swift
//  AtlasTeam
//
//  Created by Luke Mason on 1/30/22.
//

import SwiftUI

struct CompleteTrainingListHeader: View {
    var body: some View {
        HStack {
            Text("Dates")
                .font(.system(size: 20, weight: .semibold, design: .rounded))
            Spacer()
            Divider()
            HStack {
                HStack{
                    Spacer()
                    Text("Mileage")
                        .font(.system(size: 16, weight: .medium, design: .rounded))
                        .frame(width: 65, alignment: .center)
                }
                Divider()
                HStack{
                    Spacer()
                    Text("Rating")
                        .font(.system(size: 16, weight: .medium, design: .rounded))
                        .frame(width: 65, alignment: .center)
                    Spacer()
                }
            }
            .frame(width: 150)
        }
        .padding(.trailing, 20)
    }
}

struct CompleteTrainingListHeader_Previews: PreviewProvider {
    static var previews: some View {
        CompleteTrainingListHeader()
    }
}
