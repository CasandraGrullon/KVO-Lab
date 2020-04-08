//
//  ViewController.swift
//  KVO-Lab
//
//  Created by casandra grullon on 4/7/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit

class MyAccountViewController: UIViewController {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    
    private var usernameObserver: NSKeyValueObservation?
    private var balanceObserver: NSKeyValueObservation?
    private var userObservation: NSKeyValueObservation?
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUsername()
        configureBalance()
    }
    
    private func configureUsername() {
        usernameObserver = BankAccount.shared.observe(\.username, options: [.old, .new], changeHandler: { [weak self] (user, change) in
            guard let newUsername = change.newValue else { return }
            self?.usernameLabel.text = newUsername
        })
        
    }
    private func configureBalance() {
        balanceObserver = BankAccount.shared.observe(\.totalBalance, options: [.old, .new], changeHandler: { [weak self] (account, change) in
            guard let newBalance = change.newValue else { return }
            self?.balanceLabel.text = newBalance.description
        })
    }
    
    @IBAction func editButtonPressed(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let settingsVC = storyboard.instantiateViewController(identifier: "SettingsViewController")
        present(settingsVC, animated: true)
        
    }
    
    deinit {
        usernameObserver?.invalidate()
        balanceObserver?.invalidate()
    }
    

}

