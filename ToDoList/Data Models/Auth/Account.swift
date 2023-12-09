//
//  Account.swift
//  WA7_Solution_draft
//
//  Created by Sakib Miazi on 11/8/23.
//

import Foundation

struct Account{
    var name:String
    var email:String
    var password:String
    
    init(name: String, email: String, password: String) {
        self.name = name
        self.email = email
        self.password = password
    }
}
