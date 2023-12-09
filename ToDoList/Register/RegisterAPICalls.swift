//
//  RegisterAPICalls.swift
//  WA7-Chang-9179
//
//  Created by Chang on 2023/11/6.
//

import Foundation
import UIKit
import Alamofire
import FirebaseAuth

extension RegisterViewController: NotesAPIProtocol{
    
    func registerNewUser(user: Account) {
        
//        Auth.auth().createUser(withEmail: user.email, password: user.password) { authResult, error in
//         
//            self.notificationCenter.post(
//                name: .userRegisterSuccessful,
//                object: authResult
//            )
//            
//            self.navigationController?.popViewController(animated: true)
//        }
        
        if let url = URL(string: APIConfigs.baseURLAuth+"register"){
            
            AF.request(url, method:.post,
                       parameters:[
                            "name": user.name,
                            "email": user.email,
                            "password": user.password
                        ])
            .responseData(completionHandler: { response in
                //MARK: retrieving the status code...
                let status = response.response?.statusCode
                
                switch response.result{
                case .success(let data):
                    //MARK: there was no network error...
                    
                    //MARK: status code is Optional, so unwrapping it...
                    if let uwStatusCode = status{
                        switch uwStatusCode{
                        case 200...299:
                            let decoder = JSONDecoder()
                            do{
                                let receivedData = try decoder.decode(AuthedUser.self, from: data)
                                
                                print(receivedData.token)
                                
                                self.notificationCenter.post(
                                    name: .userRegisterSuccessful,
                                    object: receivedData.token
                                )
                                
                                self.navigationController?.popViewController(animated: true)
                                
                            }catch{
                                ValidationAlerts.showErrorAlert(self, "\(error)")
                            }
                            break
                            
                        case 400...499:
                            //MARK: the request was not valid 400-level...
                            ValidationAlerts.showErrorAlert(self, "Error! There was a problem registering! User already exists")
                            break
                            
                        default:
                            //MARK: probably a 500-level error...
                            ValidationAlerts.showErrorAlert(self, "Error! User already exists")
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
    
    func addANewNote(token: String, text: String) {
        //
    }
    
    func deleteANote(token: String, id: String) {
        //
    }
    
    
}
