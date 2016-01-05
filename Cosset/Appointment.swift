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
    let startTime: String
    let endTime: String
    let type: String!
    let ref: Firebase?
    let booked: Bool!
    let bookedByUser: String
    
    init(startTime: String, endTime: String, type: String, booked: Bool = false, key: String = "", bookedByUser: String) {
        self.key = key
        self.startTime = startTime
        self.endTime = endTime
        self.type = type
        self.booked = booked
        self.ref = nil
        self.bookedByUser = bookedByUser
    }
    
    func toAnyObject() -> AnyObject {
        return [
            "startTime": startTime,
            "endTime": endTime,
            "type": type,
            "booked": booked,
            "bookedByUser": bookedByUser
        ]
    }
}

