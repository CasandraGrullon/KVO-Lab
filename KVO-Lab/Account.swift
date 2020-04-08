//
//  User.swift
//  KVO-Lab
//
//  Created by casandra grullon on 4/8/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import Foundation

@objc class Account: NSObject {
    static var shared = Account()
    @objc dynamic var users = [AccountUser]()
}
