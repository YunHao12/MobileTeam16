//
//  ProfileScreenView.swift
//  WA7-Chang-9179
//
//  Created by Chang on 2023/11/6.
//

import UIKit
import SDWebImage
import FirebaseAuth
import FirebaseStorage
import FirebaseStorageUI

typealias profileBlock = (String) -> ()

class ProfileScreenView: UIView {
    
    var block:profileBlock?
    lazy var storage = Storage.storage()

    var labelName: UILabel!
    var imageView: UIImageView!
    var labelEmail: UILabel!
    var logoutButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupImageView()
        setupLabelName()
        setupLabelEmail()
        setupNoteButton()
        
        initConstraints()
    }
    
    func setHeaderUrl(url:String) {

        let httpsReference = storage.reference(forURL: "https://firebasestorage.googleapis.com/v0/b/todolist-4364d.appspot.com/o/" + url + "?token=d8bfe277-f862-44af-8e6c-6998e10cf9cb")
        let placeholderImage = UIImage(named: "placeholder.jpg")
        imageView.sd_setImage(with: httpsReference, placeholderImage: placeholderImage)
    }
    
    func setupImageView() {
        imageView = UIImageView(image: UIImage(named: "TopImage"))
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 50
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(imageView)
    }
    
    
    func setupLabelName() {
        labelName = UILabel()
        labelName.textAlignment = .left
        labelName.font = UIFont.systemFont(ofSize: 24)
        labelName.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelName)
    }
    
    func setupNoteButton() {
        logoutButton = UIButton()
        logoutButton.setTitle("Sign Out", for: .normal)
        logoutButton.setTitleColor(.blue, for: .normal)
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.addTarget(self, action: #selector(logoutButtonAction), for: .touchUpInside)
        addSubview(logoutButton)
    }
    
    func setupLabelEmail() {
        labelEmail = UILabel()
        labelEmail.textAlignment = .left
        labelEmail.font = UIFont.systemFont(ofSize: 24)
        labelEmail.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelEmail)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            
            imageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 40),
            imageView.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.heightAnchor.constraint(equalToConstant: 100),
            
            labelName.topAnchor.constraint(equalTo: self.imageView.safeAreaLayoutGuide.bottomAnchor, constant: 40),
            labelName.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            labelName.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            
            labelEmail.topAnchor.constraint(equalTo: self.labelName.bottomAnchor, constant: 20),
            labelEmail.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            labelEmail.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            
            logoutButton.topAnchor.constraint(equalTo: self.labelEmail.bottomAnchor, constant: 200),
            logoutButton.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            logoutButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func logoutButtonAction(sender:UIButton) {
        
        if let block = self.block {
            block("tap")
        }
    }
}
