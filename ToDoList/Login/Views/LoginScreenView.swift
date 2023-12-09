//
//  LoginScreenView.swift
//  WA7-Chang-9179
//
//  Created by Chang on 2023/11/6.
//

import UIKit

class LoginScreenView: UIView {
    
    var contentWrapper: UIScrollView!
    var topLabel: UILabel!
    var textFieldEmail: UITextField!
    var textFieldPassword: UITextField!
    var buttonLogin: UIButton!
    var buttonToRegisterScreen: UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupContentWrapper()
        setupTopLabel()
        setupTextFieldEmail()
        setupTextFieldPassword()
        setupButtonLogin()
        setupButtonToRegisterScreen()
        
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupContentWrapper() {
        contentWrapper = UIScrollView()
        contentWrapper.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(contentWrapper)
    }
    
    func setupTopLabel() {
        topLabel = UILabel()
        topLabel.text = "TO DO List"
        topLabel.font = .boldSystemFont(ofSize: 36)
        topLabel.textColor = .lightGray
        topLabel.textAlignment = .center
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(topLabel)
    }
    
    func setupTextFieldEmail() {
        textFieldEmail = UITextField()
        textFieldEmail.borderStyle = .roundedRect
        textFieldEmail.keyboardType = .emailAddress
        textFieldEmail.placeholder = "Email Address"
        textFieldEmail.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(textFieldEmail)
    }

    func setupTextFieldPassword() {
        textFieldPassword = UITextField()
        textFieldPassword.borderStyle = .roundedRect
        textFieldPassword.isSecureTextEntry = true
        textFieldPassword.placeholder = "Password"
        textFieldPassword.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(textFieldPassword)
    }
    
    func setupButtonLogin() {
        buttonLogin = UIButton(type: .system)
        buttonLogin.setTitle("Login", for: .normal)
        buttonLogin.backgroundColor = .lightGray
        buttonLogin.setTitleColor(.white, for: .normal)
        buttonLogin.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        buttonLogin.translatesAutoresizingMaskIntoConstraints = false
        buttonLogin.layer.masksToBounds = true
        buttonLogin.layer.cornerRadius = 10.0
        contentWrapper.addSubview(buttonLogin)
    }
    
    func setupButtonToRegisterScreen() {
        buttonToRegisterScreen = UIButton(type: .system)
        buttonToRegisterScreen.setTitleColor(.blue, for: .normal)
        buttonToRegisterScreen.setTitle("Create An Account", for: .normal)
        buttonToRegisterScreen.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        buttonToRegisterScreen.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(buttonToRegisterScreen)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            contentWrapper.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            contentWrapper.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            contentWrapper.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor),
            contentWrapper.heightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.heightAnchor),
            
            topLabel.widthAnchor.constraint(equalToConstant: 300),
            topLabel.heightAnchor.constraint(equalToConstant: 120),
            topLabel.topAnchor.constraint(equalTo: contentWrapper.topAnchor, constant: 25),
            topLabel.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            
            textFieldEmail.topAnchor.constraint(equalTo: self.topLabel.bottomAnchor, constant: 65),
            textFieldEmail.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            textFieldEmail.leadingAnchor.constraint(equalTo: self.contentWrapper.leadingAnchor, constant: 30),
            textFieldEmail.heightAnchor.constraint(equalToConstant: 50),
            
            textFieldPassword.topAnchor.constraint(equalTo: self.textFieldEmail.bottomAnchor, constant: 30),
            textFieldPassword.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            textFieldPassword.leadingAnchor.constraint(equalTo: self.contentWrapper.leadingAnchor, constant: 30),
            textFieldPassword.heightAnchor.constraint(equalToConstant: 50),
            
            buttonLogin.topAnchor.constraint(equalTo: self.textFieldPassword.bottomAnchor, constant: 30),
            buttonLogin.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            buttonLogin.leadingAnchor.constraint(equalTo: self.contentWrapper.leadingAnchor, constant: 30),
            buttonLogin.heightAnchor.constraint(equalToConstant: 50),
            
            buttonToRegisterScreen.topAnchor.constraint(equalTo: self.buttonLogin.bottomAnchor, constant: 20),
            buttonToRegisterScreen.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            buttonToRegisterScreen.bottomAnchor.constraint(equalTo: contentWrapper.bottomAnchor),
            buttonToRegisterScreen.leadingAnchor.constraint(equalTo: self.contentWrapper.leadingAnchor, constant: 30),
            buttonToRegisterScreen.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}
