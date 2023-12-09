//
//  LoginResponse.swift
//  WA7-Chang-9179
//
//  Created by Chang on 2023/11/6.
//

import Foundation

struct AccountResponse: Codable {
    let auth: Bool
    let token: String
}
