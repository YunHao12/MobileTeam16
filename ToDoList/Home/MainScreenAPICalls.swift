//
//  MainScreenAPICalls.swift
//  WA7_Solution_draft
//
//  Created by Sakib Miazi on 11/8/23.
//

import Foundation
import UIKit
import Alamofire

extension HomeViewController: NotesAPIProtocol{
    
    func login(email: String, password: String) {
        //MARK: logging in....
        if let url = URL(string: APIConfigs.baseURLAuth+"login"){
            AF.request(url, method:.post, 
                       parameters:[
                        "email": email,
                        "password": password
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
                                
                                self.authToken = receivedData.token
                                
                                self.saveTokenToLocalStorage(token: self.authToken!)
                                
                                self.getUserDetails(token: self.authToken!)
                                
                                self.getAllNotes(token: self.authToken!)
                                
                                self.isLoggedIn = true
                                
                            }catch{
                                print("\(error)")
                            }
                            print(data)
                            break
                            
                        case 400...499:
                            //MARK: the request was not valid 400-level...
                            ValidationAlerts.showErrorAlert(self, "Incorrect Username/Password")
                            break
                            
                        default:
                            //MARK: probably a 500-level error...
                            ValidationAlerts.showErrorAlert(self, "Server Error!")
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
            ValidationAlerts.showErrorAlert(self, "Invalid URL!")
        }
    }
    
    func logout() {
        if let url = URL(string: APIConfigs.baseURLAuth+"logout"){
            
            AF.request(url, method:.get)
                .responseData(completionHandler: { response in
                    //MARK: retrieving the status code...
                    let status = response.response?.statusCode
                    
                    switch response.result{
                    case .success(_):
                        //MARK: there was no network error...
                        
                        //MARK: status code is Optional, so unwrapping it...
                        if let uwStatusCode = status{
                            switch uwStatusCode{
                            case 200...299:
                                self.isLoggedIn = false
                                self.setLoggedOutDisplay()
                                self.removeTokenFromLocalStorage()
                            
                                break
                                
                            case 400...499:
                                //MARK: the request was not valid 400-level...
                                print("TEST2")
                                break
                                
                            default:
                                //MARK: probably a 500-level error...
                                print("TEST3")
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
    
    func getUserDetails(token: String) {
        if let url = URL(string: APIConfigs.baseURLAuth+"me"){
            
            AF.request(url, method:.get, 
                       headers: ["x-access-token": token])
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
                                    self.loggedInUserDetails = try decoder.decode(AccountDetails.self, from: data)
                                    if let name = self.loggedInUserDetails?.name{
                                        self.setLoggedInDisplay(name: name)
                                    }
                                }catch{
                                    print("\(error)")
                                }
                                break
                                
                            case 400...499:
                                //MARK: the request was not valid 400-level...
                                ValidationAlerts.showErrorAlert(self, "API token not valid!")
                                break
                                
                            default:
                                //MARK: probably a 500-level error...
                                print("Login Again!")
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
    
    func getAllNotes(token: String) {
        if let url = URL(string: APIConfigs.baseURLNotes+"getAll"){
            
            AF.request(url, method:.get, headers: ["x-access-token": token])
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
                                    self.notesList.removeAll()
                                    let receivedData = try decoder.decode(Notes.self, from: data)
                                    
                                    for item in receivedData.notes{
                                        self.notesList.append(item.self)
                                    }
                                    self.mainScreenView.tableViewNotes.reloadData()
                                }catch{
                                    print("Decoding error: \(error)")
                                }
                                break
                                
                            case 400...499:
                                //MARK: the request was not valid 400-level...
                                print("TEST2")
                                break
                                
                            default:
                                //MARK: probably a 500-level error...
                                print("TEST3")
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
    
    func addANewNote(token: String, text: String) {
        //
    }
    
    func deleteANote(token: String, id: String) {
        if let url = URL(string: APIConfigs.baseURLNotes+"delete"){
            
            AF.request(url, method:.post,
                       parameters: ["id": "\(id)"],
                       headers: ["x-access-token": token])
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
                                self.getAllNotes(token: token)
                                print("NOTE DELETED")
                                break
                                
                            case 400...499:
                                //MARK: the request was not valid 400-level...
                                
                                break
                                
                            default:
                                //MARK: probably a 500-level error...
                                
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
    
    
    
}
