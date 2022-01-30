//
//  Athlete.swift
//  AtlasTeam
//
//  Created by Luke Mason on 1/28/22.
//

import Foundation
import CloudKit

struct Athlete {
    let username: String
    let email: String
    let activityRecords: [CKRecord.Reference]
    var activitiesUnwrapped: [Training]
}
