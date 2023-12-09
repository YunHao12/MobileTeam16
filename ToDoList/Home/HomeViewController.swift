//
//  HomeViewController.swift
//  ToDoList
//
//  Created by azure on 2023/11/20.
//

import UIKit

class HomeViewController: UIViewController {
    
    let tokenStorage = UserDefaults.standard
    
    let notificationCenter = NotificationCenter.default
    
    let mainScreenView = NotesScreenView()
    
    var notesList = [Note]()
    
    var isLoggedIn = false
    
    var authToken: String?
    
    var loggedInUserDetails: AccountDetails?
    
    override func loadView() {
        view = mainScreenView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //MARK: check if there is any api key stored in the user defaults
        
        let apiKeySaved = tokenStorage.object(forKey: GlobalConfigs.tokenKey) as! String?
        
        if let apiKey = apiKeySaved{
            //MARK: tasks if there is a key saved it's time to call the API to get the user details and all the notes...
            print("The Saved API Key: \(apiKey)")
            authToken = apiKey
            getDataForUser(token: apiKey)
            
        }else{
            //MARK: tasks if there is no key saved, so display sign in or register...
            isLoggedIn = false
            setLoggedOutDisplay()
            print("No API Key saved at the moment!")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "TO DO List"
        navigationController?.navigationBar.prefersLargeTitles = true

        mainScreenView.tableViewNotes.delegate = self
        mainScreenView.tableViewNotes.dataSource = self
        
        notificationCenter.addObserver(
            self,
            selector: #selector(onRegisterSuccessful),
            name: .userRegisterSuccessful,
            object: nil
        )
        
        notificationCenter.addObserver(
            self,
            selector: #selector(onNewNoteAdded),
            name: .addedANewNote,
            object: nil
        )
        
        mainScreenView.floatingButtonAddNote.addTarget(self, action: #selector(onAddNoteButtonTapped), for:.touchUpInside)
    }
    
    //MARK: Get Data for logged in user...
    func getDataForUser(token: String){
        getUserDetails(token: token)
        getAllNotes(token: token)
    }
    
    //MARK: observe register successful...
    @objc func onRegisterSuccessful(notification: Notification){
        authToken = notification.object as? String
        tokenStorage.setValue(authToken!, forKey: GlobalConfigs.tokenKey)
        getUserDetails(token: authToken!)
        isLoggedIn = true
    }
    
    //MARK: observe new note added...
    @objc func onNewNoteAdded(){
        getAllNotes(token: authToken!)
    }
    
    //MARK: Add new note button tapped...
    @objc func onAddNoteButtonTapped(){
        let addNewNoteViewController = AddNoteViewController()
        addNewNoteViewController.authToken = authToken
        addNewNoteViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(addNewNoteViewController, animated: true)
    }
    
    //MARK: Store token to user defaults...
    func saveTokenToLocalStorage(token : String){
        tokenStorage.setValue(token, forKey: GlobalConfigs.tokenKey)
    }
    
    //MARK: Delete stored token from user defaults...
    func removeTokenFromLocalStorage(){
        tokenStorage.removeObject(forKey: GlobalConfigs.tokenKey)
    }
    
    //MARK: user logged in....
    func setLoggedInDisplay(name: String){
        self.mainScreenView.labelName.text = "Welcome \(name)!"
        view.bringSubviewToFront(mainScreenView.floatingButtonAddNote)
        self.mainScreenView.floatingButtonAddNote.isEnabled = true
        self.mainScreenView.floatingButtonAddNote.isHidden = false
        self.mainScreenView.profilePic.isEnabled = true
    }
    
    //MARK: user logged out...
    func setLoggedOutDisplay(){
        self.mainScreenView.labelName.text = "Please sign in to see the notes!"
        self.mainScreenView.floatingButtonAddNote.isEnabled = false
        self.mainScreenView.floatingButtonAddNote.isHidden = true
        
        self.mainScreenView.profilePic.isEnabled = false
        
        self.notesList.removeAll()
        self.mainScreenView.tableViewNotes.reloadData()
    }

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GlobalConfigs.tableViewNotesID, for: indexPath) as! NotesTableViewCell
        cell.labelName.text = notesList[indexPath.row].text
        cell.selectionStyle = .none
        cell.block = { value in
            print(indexPath.row)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let noteDetailViewController = NoteDetailViewController()
        noteDetailViewController.note = notesList[indexPath.row]
        navigationController?.pushViewController(noteDetailViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        var deleteAction = UITableViewRowAction(style: .destructive, title: "Delete"){ action, arg  in
            self.deleteANote(token: self.authToken!, id: self.notesList[indexPath.row]._id)
        }
        return [deleteAction]
    }
}

