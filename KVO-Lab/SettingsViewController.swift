//
//  SettingsViewController.swift
//  KVO-Lab
//
//  Created by casandra grullon on 4/7/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var accountBalanceTextField: UITextField!
    
    private var usernameObserver: NSKeyValueObservation?
    private var balanceObserver: NSKeyValueObservation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextFields()
        configureSettings()
    }
    private func configureTextFields() {
        usernameTextField.delegate = self
        accountBalanceTextField.delegate = self
    }
    private func configureSettings() {
        AccountUser.shared.username = usernameTextField.text ?? ""
        let newBalance = accountBalanceTextField.text?.convertToDouble() ?? 0.00
        AccountUser.shared.totalBalance = newBalance
    }
    
    @IBAction func doneButtonPressed(_ sender: UIButton) {
        configureSettings()
        dismiss(animated: true)
    }
    
}
extension SettingsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension String {
    func convertToDouble() -> Double? {
        return NumberFormatter().number(from: self)?.doubleValue
    }
}