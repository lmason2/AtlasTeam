//
//  Team.swift
//  AtlasTeam
//
//  Created by Luke Mason on 1/28/22.
//

import Foundation
import CloudKit
import UIKit

struct Team {
    var assistantCoaches: [CKRecord.Reference]
    var athletes: [CKRecord.Reference]
    var coach: CKRecord.Reference
    var location: CLLocation
    var name: String
    var password: String
    var trainers: [CKRecord.Reference]
    var primaryString: String
    var secondaryString: String
    var primaryColor: UIColor {
        UIColor(hex: primaryString)!
    }
    var secondaryColor: UIColor {
        UIColor(hex: secondaryString)!
    }
}
