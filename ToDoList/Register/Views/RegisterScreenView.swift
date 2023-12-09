//
//  RegisterScreenView.swift
//  WA7-Chang-9179
//
//  Created by Chang on 2023/11/6.
//

import UIKit

class RegisterScreenView: UIView {

    var contentWrapper: UIScrollView!
    var topLabel: UILabel!
    var labelName: UILabel!
    var textFieldName: UITextField!
    var labelEmail: UILabel!
    var textFieldEmail: UITextField!
    var labelPassword: UILabel!
    var textFieldPassword: UITextField!
    var buttonRegister: UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupContentWrapper()
        setupTopLabel()
        setupTextFieldName()
        setupTextFieldEmail()
        setupTextFieldPassword()
        setupButtonRegister()
        
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
        topLabel.text = "Register"
        topLabel.font = .boldSystemFont(ofSize: 36)
        topLabel.textColor = .lightGray
        topLabel.textAlignment = .center
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(topLabel)
    }
    
    func setupTextFieldName() {
        textFieldName = UITextField()
        textFieldName.borderStyle = .roundedRect
        textFieldName.placeholder = "Your Name"
        textFieldName.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(textFieldName)
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
        textFieldPassword.keyboardType = .emailAddress
        textFieldPassword.placeholder = "Create Password"
        textFieldPassword.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(textFieldPassword)
    }
    
    func setupButtonRegister() {
        buttonRegister = UIButton(type: .system)
        buttonRegister.backgroundColor = .lightGray
        buttonRegister.setTitleColor(.white, for: .normal)
        buttonRegister.setTitle("Create Account", for: .normal)
        buttonRegister.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        buttonRegister.layer.masksToBounds = true
        buttonRegister.layer.cornerRadius = 10.0
        buttonRegister.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(buttonRegister)
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
            
            textFieldName.topAnchor.constraint(equalTo: self.topLabel.bottomAnchor, constant: 65),
            textFieldName.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            textFieldName.leadingAnchor.constraint(equalTo: self.contentWrapper.leadingAnchor, constant: 30),
            textFieldName.heightAnchor.constraint(equalToConstant: 50),
            
            textFieldEmail.topAnchor.constraint(equalTo: self.textFieldName.bottomAnchor, constant: 30),
            textFieldEmail.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            textFieldEmail.leadingAnchor.constraint(equalTo: self.contentWrapper.leadingAnchor, constant: 30),
            textFieldEmail.heightAnchor.constraint(equalToConstant: 50),
            
            textFieldPassword.topAnchor.constraint(equalTo: self.textFieldEmail.bottomAnchor, constant: 30),
            textFieldPassword.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            textFieldPassword.leadingAnchor.constraint(equalTo: self.contentWrapper.leadingAnchor, constant: 30),
            textFieldPassword.heightAnchor.constraint(equalToConstant: 50),
            
            buttonRegister.topAnchor.constraint(equalTo: self.textFieldPassword.bottomAnchor, constant: 60),
            buttonRegister.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            buttonRegister.leadingAnchor.constraint(equalTo: self.contentWrapper.leadingAnchor, constant: 30),
            buttonRegister.heightAnchor.constraint(equalToConstant: 50),
            
        ])
    }

}
