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
    
    private var users = [BankAccount]() {
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
        userObservation = User.shared.observe(\.users, options: [.old, .new], changeHandler: { [weak self] (user, change) in
            guard let user = change.newValue else {return}
            self?.users = user
        })
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
        cell.textLabel?.text = user.username
        cell.detailTextLabel?.text = "$\(user.totalBalance)"
        return cell
    }
    
    
}
