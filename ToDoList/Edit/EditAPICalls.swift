//
//  EditAPICalls.swift
//  ToDoList
//
//  Created by azure on 2023/12/6.
//

import Foundation

import UIKit
import Alamofire
import FirebaseAuth

extension EditViewController: EditProtocol {
    
    func userEdit(email: String, password: String) {
        
        print("function called")
        if let url = URL(string: APIConfigs.baseURLAuth + "login") {
            AF.request(url, method: .post, parameters:
                        [
                            "email": email,
                            "password": password
                        ])
            .responseData(completionHandler: {response in
                let status = response.response?.statusCode
                switch response.result {
                case .success(let data):
                    if let uwStatusCode = status {
                        switch uwStatusCode {
                        case 200...299:
                            let decoder = JSONDecoder()
                            do {
                                let receivedData =
                                try decoder.decode(AccountResponse.self, from: data)
                                let token = receivedData.token
                                UserDefaults.standard.set(token, forKey: "token")
                                let storyboard = UIStoryboard.init(name: "Main", bundle: nil);
                                let mainScreenViewController = storyboard.instantiateViewController(identifier: "HomeTabBarController")
                                // MARK: change the root view controller
                                if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                                    sceneDelegate.switchToMainScreenController()
                                }
                                self.navigationController?.pushViewController(mainScreenViewController, animated: true)
                       
                            } catch {
                                print("JSON couldn't be decoded.")
                            }
                            break
                            
                        case 400...499:
                            self.showLoginErrorAlert()
                            break
                            
                        default:
                            print(data)
                            break
                        }
                    }
                    break
                    
                case .failure(let error):
                    print(error)
                    break
                }
            })
        }
    }
}
