//
//  RosentalTabBarController.swift
//  RosentalApp
//
//  Created by Ваня Сокол on 04.09.2024.
//

import UIKit

final class RosentalTabBarController: UITabBarController {
    
    var model: [CustomerElements]?
    var username: String?
    var password: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = configureTabBar(with: model, for: username, password: password)
        UITabBar.appearance().tintColor = UIColor(named: "tabBarBlue")
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewControllers = configureTabBar(with: model, for: username, password: password)
    }
    
    private func configureTabBar(with model: [CustomerElements]?, for username: String?, password: String?) -> [UIViewController] {
        
        let profileViewController = ProfileViewController(username: username, password: password)
        profileViewController.tabBarItem = UITabBarItem(title: model?[0].name ?? "Главная", image: UIImage(systemName: "key"), tag: 0)
        
        let bidViewController = EmptyViewController()
        bidViewController.tabBarItem = UITabBarItem(title: model?[1].name ?? "Заявки", image: UIImage(systemName: "text.book.closed"), tag: 1)
        
        let chatViewController = EmptyViewController()
        chatViewController.tabBarItem = UITabBarItem(title: model?[2].name ??  "Чат", image: UIImage(systemName: "star"), tag: 2)
        
        let contactsViewController = EmptyViewController()
        contactsViewController.tabBarItem = UITabBarItem(title: model?[3].name ??  "Контакты", image: UIImage(systemName: "person.crop.artframe"), tag: 3)
        
        return [
            profileViewController,
            bidViewController,
            chatViewController,
            contactsViewController
        ]
    }
}
