//
//  Note.swift
//  WA7_Solution_draft
//
//  Created by Sakib Miazi on 11/8/23.
//

import Foundation

struct Note: Codable {
    let _id: String
    let userId: String
    let text: String
}

struct Notes: Codable {
    let notes: [Note]
}
