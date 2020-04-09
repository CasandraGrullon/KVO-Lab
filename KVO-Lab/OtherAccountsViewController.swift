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
    
    private var userObservation: NSKeyValueObservation?
    private var balanceObservation: NSKeyValueObservation?
    
    private var users = [AccountUser]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUserObservation()
        tableView.dataSource = self
    }
    
    private func configureUserObservation() {
        users = Account.shared.users
    }
    
    deinit {
        userObservation?.invalidate()
    }

}
extension OtherAccountsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
        let user = users[indexPath.row]
        cell.detailTextLabel?.text = "$\(user.totalBalance)"
        if user.username == AccountUser.shared.username {
            balanceObservation = AccountUser.shared.observe(\.totalBalance, options: [.old, .new], changeHandler: { (balance, change) in
                guard let newBalance = change.newValue else {return}
                cell.detailTextLabel?.text = "$\(newBalance)"
            })
        }
        cell.textLabel?.text = user.username
        
        return cell
    }
    
    
}
