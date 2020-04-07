//
//  OtherAccountsViewController.swift
//  KVO-Lab
//
//  Created by casandra grullon on 4/7/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit

class OtherAccountsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var userObserver: NSKeyValueObservation?
    private var balanceObserver: NSKeyValueObservation?
    
    private var users = [AccountUser]() {
        didSet {
            tableView.reloadData()
        }
    }
    private var usernames = [String]()
    private var balances = [Double]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUserObservation()
        configureBalanceObservation()
        tableView.dataSource = self
    }
    
    private func configureUserObservation() {
        userObserver = AccountUser.shared.observe(\.username, options: [.old,.new], changeHandler: { [weak self] (user, change) in
            guard let newUser = change.newValue else { return }
            self?.users.first?.username = newUser
        })
        balanceObserver = AccountUser.shared.observe(\.totalBalance, options: [.old, .new], changeHandler: { [weak self] (account, change) in
            guard let newbalance = change.newValue else {return}
            self?.users.first?.totalBalance = newbalance
        })
         
        
    }
    private func configureBalanceObservation() {

    }
    deinit {
        userObserver?.invalidate()
        balanceObserver?.invalidate()
    }


}
extension OtherAccountsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
        let user = users[indexPath.row]
        cell.textLabel?.text = user.username
        cell.detailTextLabel?.text = user.totalBalance.description
        return cell
    }
    
    
}
