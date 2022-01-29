//
//  CompeteTrainingDetailView.swift
//  AtlasTeam
//
//  Created by Luke Mason on 1/29/22.
//

import SwiftUI

struct CompleteTrainingDetailView: View {
    var body: some View {
        List {
            ForEach(0..<5) { _ in
                Text("test")
            }
        }
    }
}

struct CompeteTrainingDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CompleteTrainingDetailView()
    }
}
