//
//  ProfileModel.swift
//  RosentalApp
//
//  Created by Ваня Сокол on 01.09.2024.
//

import Foundation

struct ProfileModel: Decodable {
    let customerDashboard: DashboardElements
    let myProfile: MyProfile
    let myNewNotifications: Int
    
    enum CodingKeys: String, CodingKey {
        case customerDashboard = "customer_dashboard"
        case myProfile = "my_profile"
        case myNewNotifications = "my_new_notifications"
    }
}

struct DashboardElements: Decodable {
    let notifications: Notifications
    let date: String
    let menuItems: [MenuItems]
    let banners: [Banners]
    let services: [Services]
    let navBar: [NavBar]
    
    enum CodingKeys: String, CodingKey {
        case notifications, banners, services, date
        case menuItems = "menu_items"
        case navBar = "navbar"
    }
}

struct Notifications: Decodable {
    let count: Int
    
    enum CodingKeys: String, CodingKey {
        case count
    }
}

struct NavBar: Decodable {
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case name
    }
}

struct MenuItems: Decodable {
    let action: String
    let name: String
    let description: String
    let expected: Expected?
    let arrear: String?
    
    enum CodingKeys: String, CodingKey {
        case action, name, description, arrear, expected
    }
}

struct Expected: Decodable {
    let lastDate: String
    let indications: [Indications]
    
    enum CodingKeys: String, CodingKey {
        case lastDate = "last_date"
        case indications
    }
}

struct Indications: Decodable {
    let label: String
    let lastTransfer: String
    
    enum CodingKeys: String, CodingKey {
        case label
        case lastTransfer = "last_transfer"
    }
}

struct Banners: Decodable {
    let title: String
    let text: String
    let image: String
    let action: String
    let priority: Int
    
    enum CodingKeys: String, CodingKey {
        case title, text, image, action, priority
    }
}

struct MyProfile: Decodable {
    let shortName: String
    let photo: String
    let address: String
    
    enum CodingKeys: String, CodingKey {
        case shortName = "short_name"
        case photo
        case address
    }
}

struct Services: Decodable {
    let name: String
    let action: String
    let order: Int
    
    enum CodingKeys: String, CodingKey {
        case name, action, order
    }
}
