//
//  AddNoteAPICalls.swift
//  WA7_Solution_draft
//
//  Created by Sakib Miazi on 11/9/23.
//

import Foundation
import Alamofire
import UIKit

extension AddNoteViewController:NotesAPIProtocol{
    
    func addANewNote(token: String, text: String) {
        if let url = URL(string: APIConfigs.baseURLNotes+"post"){
            
            AF.request(url, method:.post, parameters:
                        [
                            "text": text
                        ], headers: ["x-access-token": token])
            .responseString(completionHandler: { response in
                //MARK: retrieving the status code...
                let status = response.response?.statusCode
                
                switch response.result{
                case .success(let data):
                    //MARK: there was no network error...
                    
                    //MARK: status code is Optional, so unwrapping it...
                    if let uwStatusCode = status{
                        switch uwStatusCode{
                        case 200...299:
                            self.notificationCenter.post(
                                name: .addedANewNote,
                                object: nil)
                            self.navigationController?.popViewController(animated: true)
                            break
                            
                        case 400...499:
                            //MARK: the request was not valid 400-level...
                            print(data)
                            break
                            
                        default:
                            //MARK: probably a 500-level error...
                            print(data)
                            break
                            
                        }
                    }
                    break
                    
                case .failure(let error):
                    //MARK: there was a network error...
                    print(error)
                    break
                }
            })
        }else{
            //alert that the URL is invalid...
        }
    }
    
    func registerNewUser(user: Account) {
        //
    }
    
    func login(email: String, password: String) {
        //
    }
    
    func logout() {
        //
    }
    
    func getUserDetails(token: String) {
        //
    }
    
    func getAllNotes(token: String) {
        //
    }
    
    func deleteANote(token: String, id: String) {
        //
    }
    
    
}
