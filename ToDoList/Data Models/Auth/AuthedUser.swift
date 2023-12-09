//
//  AuthedUser.swift
//  WA7_Solution_draft
//
//  Created by Sakib Miazi on 11/8/23.
//

import Foundation

struct AuthedUser : Codable{
    let auth: Bool
    let token: String
}
