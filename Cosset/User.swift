//
//  User.swift
//  Cosset
//
//  Created by Lauren Nicole Roth on 1/4/16.
//  Copyright © 2016 Cosset. All rights reserved.
//

import Foundation
import Firebase

struct User {
    let uid: String
    let email: String
    let username: String


    init(authData: FAuthData) {
        uid = authData.uid
        email = authData.providerData["email"] as! String
        username = authData.providerData["username"] as! String
    }
    
    init(uid: String, email: String, username: String) {
        self.uid = uid
        self.email = email
        self.username = username
    }
}
