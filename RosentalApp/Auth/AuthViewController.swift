//
//  AuthViewController.swift
//  RosentalApp
//
//  Created by Ваня Сокол on 31.08.2024.
//

import UIKit

final class AuthViewController: UIViewController {
    
    private let backButton = UIButton()
    private let forgetPasswordButton = UIButton()
    private let entryLabel = UILabel()
    private let emailLabel = TextFieldLabelView(with: "E-mail")
    private let passwordLabel = TextFieldLabelView(with: "Пароль")
    private let usernameTextField = UITextField()
    private let passwordTextField = UITextField()
    private let entryButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupLayout()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        backButton.tintColor = .black
        backButton.backgroundColor = UIColor(named: "rosentalGray")
        backButton.layer.cornerRadius = 17.5
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        forgetPasswordButton.setTitle("Забыли пароль?", for: .normal)
        forgetPasswordButton.setTitleColor(.black, for: .normal)
        
        entryLabel.text = "Вход в аккаунт"
        entryLabel.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        
        usernameTextField.placeholder = " E-mail"
        usernameTextField.font = UIFont.systemFont(ofSize: 20)
        usernameTextField.layer.cornerRadius = 8
        usernameTextField.layer.borderWidth = 1
        usernameTextField.layer.borderColor = UIColor(named: "borderGray")?.cgColor
        usernameTextField.keyboardType = .emailAddress
        
        passwordTextField.placeholder = " Пароль"
        passwordTextField.font = UIFont.systemFont(ofSize: 20)
        passwordTextField.layer.cornerRadius = 8
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.borderColor = UIColor(named: "borderGray")?.cgColor
        passwordTextField.isSecureTextEntry = true
        
        entryButton.setTitle("Войти", for: .normal)
        entryButton.setTitleColor(.black, for: .normal)
        entryButton.backgroundColor = UIColor(named: "orangeButton")
        entryButton.layer.cornerRadius = 8
        entryButton.addTarget(self, action: #selector(entryButtonTapped), for: .touchUpInside)
    }
    
    private func setupLayout() {
        let views = [
            backButton,
            forgetPasswordButton,
            entryLabel,
            usernameTextField,
            passwordTextField,
            passwordLabel,
            emailLabel,
            entryButton
        ]
        
        views.forEach { item in
            view.addSubview(item)
            item.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
        backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
        backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
        backButton.heightAnchor.constraint(equalToConstant: 35),
        backButton.widthAnchor.constraint(equalToConstant: 35),
        
        forgetPasswordButton.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
        forgetPasswordButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
        forgetPasswordButton.heightAnchor.constraint(equalToConstant: 20),
        
        entryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
        entryLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
        entryLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 32),
        
        usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
        usernameTextField.topAnchor.constraint(equalTo: entryLabel.bottomAnchor, constant: 32),
        usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
        usernameTextField.heightAnchor.constraint(equalToConstant: 60),
        
        emailLabel.leadingAnchor.constraint(equalTo: usernameTextField.leadingAnchor, constant: 8),
        emailLabel.centerYAnchor.constraint(equalTo: usernameTextField.topAnchor),
        
        passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
        passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 24),
        passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
        passwordTextField.heightAnchor.constraint(equalToConstant: 60),
        
        passwordLabel.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor, constant: 8),
        passwordLabel.centerYAnchor.constraint(equalTo: passwordTextField.topAnchor),
        
        entryButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
        entryButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 22),
        entryButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
        entryButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc private func entryButtonTapped() {
        guard let username = usernameTextField.text,
              let password = passwordTextField.text else
        { return }
              
        NetworkService.shared.makeAuthRequest(for: username, password: password) { [weak self] result in
            let tabBarController = RosentalTabBarController()
            
            switch result {
                
            case .success(let response):
                if response.login == "ok" {
                    tabBarController.model = response.customerNavbar
                    tabBarController.username = username
                    tabBarController.password = password
                    self?.navigationController?.pushViewController(tabBarController, animated: true)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
