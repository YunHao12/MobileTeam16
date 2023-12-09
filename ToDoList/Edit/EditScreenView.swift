//
//  EditScreenView.swift
//  ToDoList
//
//  Created by azure on 2023/12/6.
//

import Foundation
import UIKit
import FirebaseStorageUI
import FirebaseAuth
import FirebaseStorage

class EditScreenView: UIView {
    
    var contentWrapper: UIScrollView!
    var imageView: UIImageView!
    var textFieldEmail: UITextField!
    var textFieldPassword: UITextField!
    var editLogin: UIButton!
    var buttonToRegisterScreen: UIButton!
    lazy var storage = Storage.storage()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupContentWrapper()
        setupButtonHeader()
        setupTextFieldEmail()
        setupTextFieldPassword()
        setupButtonLogin()
        
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setHeaderUrl(url:String) {
        
        let httpsReference = storage.reference(forURL: "https://firebasestorage.googleapis.com/v0/b/todolist-4364d.appspot.com/o/" + url + "?token=d8bfe277-f862-44af-8e6c-6998e10cf9cb")
        let placeholderImage = UIImage(named: "placeholder.jpg")
        imageView.sd_setImage(with: httpsReference, placeholderImage: placeholderImage)
    }
    
    func setupContentWrapper() {
        contentWrapper = UIScrollView()
        contentWrapper.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(contentWrapper)
    }
    
    func setupButtonHeader() {
        imageView = UIImageView(image: UIImage(named: "TopImage"))
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 50
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(imageView)
    }
    
    func setupTextFieldEmail() {
        textFieldEmail = UITextField()
        textFieldEmail.borderStyle = .roundedRect
        textFieldEmail.keyboardType = .emailAddress
        textFieldEmail.placeholder = "Your Name"
        textFieldEmail.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(textFieldEmail)
    }

    func setupTextFieldPassword() {
        textFieldPassword = UITextField()
        textFieldPassword.borderStyle = .roundedRect
        textFieldPassword.keyboardType = .emailAddress
        textFieldPassword.placeholder = "Email Address"
        textFieldPassword.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(textFieldPassword)
    }
    
    func setupButtonLogin() {
        editLogin = UIButton(type: .system)
        editLogin.setTitle("Save", for: .normal)
        editLogin.backgroundColor = .lightGray
        editLogin.setTitleColor(.white, for: .normal)
        editLogin.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        editLogin.translatesAutoresizingMaskIntoConstraints = false
        editLogin.layer.masksToBounds = true
        editLogin.layer.cornerRadius = 10.0
        contentWrapper.addSubview(editLogin)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            contentWrapper.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            contentWrapper.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            contentWrapper.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor),
            contentWrapper.heightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.heightAnchor),
            
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.heightAnchor.constraint(equalToConstant: 100),
            imageView.topAnchor.constraint(equalTo: contentWrapper.topAnchor, constant: 25),
            imageView.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            
            textFieldEmail.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 65),
            textFieldEmail.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            textFieldEmail.leadingAnchor.constraint(equalTo: self.contentWrapper.leadingAnchor, constant: 30),
            textFieldEmail.heightAnchor.constraint(equalToConstant: 50),
            
            textFieldPassword.topAnchor.constraint(equalTo: self.textFieldEmail.bottomAnchor, constant: 30),
            textFieldPassword.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            textFieldPassword.leadingAnchor.constraint(equalTo: self.contentWrapper.leadingAnchor, constant: 30),
            textFieldPassword.heightAnchor.constraint(equalToConstant: 50),
            
            editLogin.topAnchor.constraint(equalTo: self.textFieldPassword.bottomAnchor, constant: 30),
            editLogin.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            editLogin.leadingAnchor.constraint(equalTo: self.contentWrapper.leadingAnchor, constant: 30),
            editLogin.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}
