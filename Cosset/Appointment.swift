//
//  Appointment.swift
//  Cosset
//
//  Created by Lauren Nicole Roth on 1/4/16.
//  Copyright © 2016 Cosset. All rights reserved.
//

import Foundation
import Firebase

struct Appointment {
    let key: String!
    let startTime: NSDate
    let endTime: NSDate
    let type: String!
    let ref: Firebase?
    let booked: Bool!
    
    init(startTime: NSDate, endTime: NSDate, type: String, booked: Bool = false, key: String = "") {
        self.key = key
        self.startTime = startTime
        self.endTime = endTime
        self.type = type
        self.booked = booked
        self.ref = nil
    }
}

