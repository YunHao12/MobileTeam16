//
//  NotesAPIProtocol.swift
//  WA7_Solution_draft
//
//  Created by Sakib Miazi on 11/8/23.
//

import Foundation

protocol NotesAPIProtocol{
    func registerNewUser(user: Account)
    func login(email: String, password: String)
    func logout()
    
    func getUserDetails(token: String)
    func getAllNotes(token: String)
    func addANewNote(token: String, text: String)
    func deleteANote(token: String, id: String)
}
