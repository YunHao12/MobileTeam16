//
//  RegisterViewController.swift
//  WA7-Chang-9179
//
//  Created by Chang on 2023/11/6.
//

import UIKit
import Alamofire

class RegisterViewController: UIViewController {
    
    let registerScreenView = RegisterScreenView()
    
    let notificationCenter = NotificationCenter.default
    
    override func loadView() {
        view = registerScreenView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerScreenView.buttonRegister.addTarget(self, action: #selector(onButtonRegisterTapped), for: .touchUpInside)

        // hide keyboard when tapped outside
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        tap.cancelsTouchesInView = true
        view.addGestureRecognizer(tap)
    }
    
    @objc func onButtonRegisterTapped() {
        let name = registerScreenView.textFieldName.text!
        let email = registerScreenView.textFieldEmail.text!
        let password = registerScreenView.textFieldPassword.text!
        if !checkEmail(email: email) {
            showInvalidEmailAlert()
            return
        }
        let newUser = Account(name: name, email: email, password: password)
        registerNewUser(user: newUser)
    }
    
    func checkEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func showInvalidEmailAlert() {
        let alert = UIAlertController(title: "Error!", message: "Please input a valid email address", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
    
    func showRegisterErrorAlert() {
        let alert = UIAlertController(title: "Error!", message: "User already exists", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
    
    // hide keyboard when tapped outside
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
