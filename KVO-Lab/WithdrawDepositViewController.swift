//
//  WithdrawDepositViewController.swift
//  KVO-Lab
//
//  Created by casandra grullon on 4/7/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit

class WithdrawDepositViewController: UIViewController {

    @IBOutlet weak var totalBalanceLabel: UILabel!
    @IBOutlet weak var amountTextField: UITextField!
    
    private var balanceObserver: NSKeyValueObservation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTotalBalance()
        configureUIProperties()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        amountTextField.text = ""
    }
    private func configureUIProperties() {
        totalBalanceLabel.text = BankAccount.shared.totalBalance.description
        amountTextField.delegate = self
    }
    
    private func configureTotalBalance() {
        balanceObserver = BankAccount.shared.observe(\.totalBalance, options: [.old, .new], changeHandler: { [weak self] (account, change) in
            guard let newTotal = change.newValue else {return}
            self?.totalBalanceLabel.text = newTotal.description
        })
    }

    @IBAction func withdrawButtonPressed(_ sender: UIButton) {
        let withdrawAmount = amountTextField.text?.convertToDouble() ?? 0.0
        BankAccount.shared.totalBalance = (BankAccount.shared.totalBalance) - withdrawAmount
    }
    
    @IBAction func depositButtonPressed(_ sender: UIButton) {
        let depositAmount = amountTextField.text?.convertToDouble() ?? 0.0
        BankAccount.shared.totalBalance = (BankAccount.shared.totalBalance) + depositAmount
    }
    deinit {
        balanceObserver?.invalidate()
    }
}
extension WithdrawDepositViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
