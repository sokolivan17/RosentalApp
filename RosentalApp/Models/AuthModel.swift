//
//  AuthModel.swift
//  RosentalApp
//
//  Created by Ваня Сокол on 01.09.2024.
//

import Foundation

struct AuthModel: Decodable {
    let login: String
    let customerNavbar: [CustomerElements]
    
    enum CodingKeys: String, CodingKey {
        case login
        case customerNavbar = "customer_navbar"
    }
}

struct CustomerElements: Decodable {
    let action: String
    let name: String
}
