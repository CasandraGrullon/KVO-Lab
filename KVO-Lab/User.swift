//
//  User.swift
//  KVO-Lab
//
//  Created by casandra grullon on 4/8/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import Foundation

@objc class User: NSObject {
    static var shared = User()
    @objc dynamic var users = [BankAccount]()
}
