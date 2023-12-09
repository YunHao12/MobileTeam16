//
//  LoginViewController.swift
//  WA7-Chang-9179
//
//  Created by Chang on 2023/11/6.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {
    
    let loginScreenView = LoginScreenView()
    
    override func loadView() {
        view = loginScreenView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginScreenView.buttonLogin.addTarget(self, action: #selector(onButtonLoginTapped), for: .touchUpInside)
        
        loginScreenView.buttonToRegisterScreen.addTarget(self, action: #selector(onButtonToRegisterScreenTapped), for: .touchUpInside)

        // hide keyboard when tapped outside
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        tap.cancelsTouchesInView = true
        view.addGestureRecognizer(tap)
    }
    
    @objc func onButtonLoginTapped() {
        let email: String = loginScreenView.textFieldEmail.text!
        let password: String = loginScreenView.textFieldPassword.text!
        print(email.count)
        print(password.count)
        userLogin(email: email, password: password)
    }
    
    func showLoginErrorAlert() {
        let alert = UIAlertController(title: "Error", message: "User not exist or wrong password", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
    
    @objc func onButtonToRegisterScreenTapped() {
        let registerViewController = RegisterViewController()
        print("tapped")
        navigationController?.pushViewController(registerViewController, animated: true)
    }
    
    // hide keyboard when tapped outside
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

}
