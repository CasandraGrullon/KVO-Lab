//
//  AccountUser.swift
//  KVO-Lab
//
//  Created by casandra grullon on 4/7/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import Foundation

@objc class AccountUser: NSObject {
    static var shared = AccountUser()
    @objc dynamic var totalBalance: Double
    @objc dynamic var username: String
    
    override private init() {
        totalBalance = 0.00
        username = "user name"
    }
    
}
