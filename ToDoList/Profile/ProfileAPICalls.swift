//
//  ProfileAPICalls.swift
//  WA7-Chang-9179
//
//  Created by Chang on 2023/11/6.
//

import Foundation
import UIKit
import Alamofire

extension ProfileViewController: ProfileProtocol {
    func showProfileDetail() {
        let token = UserDefaults.standard.string(forKey: "token") ?? ""
        if(token == "") {
            let loginViewController = LoginViewController()
            self.navigationController?.pushViewController(loginViewController, animated: true)
            return
        }
        if let url = URL(string: APIConfigs.baseURLAuth + "me") {
            AF.request(url, method: .get, headers: [
                "x-access-token": token
            ]).responseData(completionHandler: {response in
                let status = response.response?.statusCode
                
                switch response.result {
                case .success(let data):
                    if let uwStatusCode = status {
                        switch uwStatusCode {
                        case 200...299:
                            let decoder = JSONDecoder()
                            do {
                                let receivedData = try decoder.decode(Profile.self, from: data)
                                self.profileScreenView.labelName.text = "Name: \(receivedData.name)"
                                self.profileScreenView.labelEmail.text = "Email: \(receivedData.email)"
                            } catch {
                                print("JSON couldn't be decoded.")
                            }
                            break
                            
                        case 400...499:
                            print(data)
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
