//
//  NotesScreen.swift
//  WA7_Solution_draft
//
//  Created by Sakib Miazi on 11/8/23.
//

import UIKit

class NotesScreenView: UIView {

    var profilePic: UIButton!
    var labelName: UILabel!
    var floatingButtonAddNote: UIButton!
    var tableViewNotes: UITableView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupProfilePic()
        setupLabelText()
        setupFloatingButtonAddNote()
        setupTableViewNotes()
        initConstraints()
    }
    
    //MARK: initializing the UI elements...
    func setupProfilePic(){
        profilePic = UIButton()
        profilePic.setTitle("", for: .normal)
        profilePic.setImage(UIImage(systemName: "person.circle")?.withRenderingMode(.alwaysOriginal), for: .normal)
        profilePic.contentHorizontalAlignment = .fill
        profilePic.contentVerticalAlignment = .fill
        profilePic.imageView?.contentMode = .scaleAspectFit
        profilePic.layer.cornerRadius = 16
        profilePic.imageView?.layer.shadowOffset = .zero
        profilePic.imageView?.layer.shadowRadius = 0.8
        profilePic.imageView?.layer.shadowOpacity = 0.7
        profilePic.imageView?.clipsToBounds = true
        profilePic.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(profilePic)
    }
    
    func setupLabelText(){
        labelName = UILabel()
        labelName.font = .boldSystemFont(ofSize: 14)
        labelName.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelName)
    }
    
    func setupTableViewNotes(){
        tableViewNotes = UITableView()
        tableViewNotes.register(NotesTableViewCell.self, forCellReuseIdentifier: GlobalConfigs.tableViewNotesID)
        tableViewNotes.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tableViewNotes)
    }
    
    func setupFloatingButtonAddNote(){
        floatingButtonAddNote = UIButton(type: .system)
        floatingButtonAddNote.setTitle("", for: .normal)
        floatingButtonAddNote.setImage(UIImage(systemName: "note.text.badge.plus")?.withRenderingMode(.alwaysOriginal), for: .normal)
        floatingButtonAddNote.contentHorizontalAlignment = .fill
        floatingButtonAddNote.contentVerticalAlignment = .fill
        floatingButtonAddNote.imageView?.contentMode = .scaleAspectFit
        floatingButtonAddNote.layer.cornerRadius = 16
        floatingButtonAddNote.imageView?.layer.shadowOffset = .zero
        floatingButtonAddNote.imageView?.layer.shadowRadius = 0.8
        floatingButtonAddNote.imageView?.layer.shadowOpacity = 0.7
        floatingButtonAddNote.imageView?.clipsToBounds = true
        floatingButtonAddNote.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(floatingButtonAddNote)
    }
    
    
    //MARK: setting up constraints...
    func initConstraints(){
        NSLayoutConstraint.activate([
            profilePic.widthAnchor.constraint(equalToConstant: 32),
            profilePic.heightAnchor.constraint(equalToConstant: 32),
            profilePic.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 8),
            profilePic.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            labelName.topAnchor.constraint(equalTo: profilePic.topAnchor),
            labelName.bottomAnchor.constraint(equalTo: profilePic.bottomAnchor),
            labelName.leadingAnchor.constraint(equalTo: profilePic.trailingAnchor, constant: 8),
            
            tableViewNotes.topAnchor.constraint(equalTo: profilePic.bottomAnchor, constant: 8),
            tableViewNotes.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            tableViewNotes.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            tableViewNotes.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            floatingButtonAddNote.widthAnchor.constraint(equalToConstant: 48),
            floatingButtonAddNote.heightAnchor.constraint(equalToConstant: 48),
            floatingButtonAddNote.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            floatingButtonAddNote.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
