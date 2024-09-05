//
//  WelcomeViewController.swift
//  RosentalApp
//
//  Created by Ваня Сокол on 29.08.2024.
//

import UIKit

final class WelcomeViewController: UIViewController {
    
    private let logoImageView = UIImageView()
    private let rosentalLabel = UILabel()
    private let backgroundImageView = UIImageView()
    private let greetingLabel = UILabel()
    private let subLabel = UILabel()
    private let buttonsStack = UIStackView()
    private let entryButton = UIButton()
    private let registrationButton = UIButton()
    private let inviteButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupLayout()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.isHidden = true
        
        logoImageView.image = UIImage(named: "logo")
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.clipsToBounds = true
        logoImageView.translatesAutoresizingMaskIntoConstraints = false

        rosentalLabel.textAlignment = .left
        rosentalLabel.numberOfLines = 0
        
        let firstAttributes = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 10), NSAttributedString.Key.foregroundColor : UIColor.black]
        
        let secondAttributes = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 22), NSAttributedString.Key.foregroundColor : UIColor.black]
        
        let firstAttributedString = NSMutableAttributedString(string:"Управляющая компания", attributes: firstAttributes)
        let secondAttributedString = NSMutableAttributedString(string:"\nРозенталь\nГрупп", attributes: secondAttributes)
        
        firstAttributedString.append(secondAttributedString)
        rosentalLabel.attributedText = firstAttributedString
        rosentalLabel.translatesAutoresizingMaskIntoConstraints = false
        
        backgroundImageView.image = UIImage(named: "background")
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.backgroundColor = .systemRed
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        
        greetingLabel.textColor = .black
        greetingLabel.text = "Добро\nпожаловать!"
        greetingLabel.numberOfLines = 0
        greetingLabel.translatesAutoresizingMaskIntoConstraints = false
        greetingLabel.font = UIFont.systemFont(ofSize: 46, weight: .bold)
        
        subLabel.text = "Авторизуйтесь, чтобы продолжить работу"
        subLabel.translatesAutoresizingMaskIntoConstraints = false
        subLabel.font = UIFont.systemFont(ofSize: 16)
        
        entryButton.setTitle("Вход", for: .normal)
        entryButton.backgroundColor = UIColor(named: "orangeButton")
        entryButton.setTitleColor(.black, for: .normal)
        entryButton.layer.cornerRadius = 8
        entryButton.addTarget(self, action: #selector(tapEntryButton), for: .touchUpInside)
        
        registrationButton.layer.borderWidth = 1
        registrationButton.setTitle("Регистрация", for: .normal)
        registrationButton.setTitleColor(.black, for: .normal)
        registrationButton.tintColor = .white
        registrationButton.layer.cornerRadius = 8
        registrationButton.layer.borderWidth = 1
        registrationButton.layer.borderColor = UIColor(named: "borderGray")?.cgColor
        
        inviteButton.setTitle(" Пригласить управлять своим домом", for: .normal)
        inviteButton.setImage(UIImage(systemName: "house"), for: .normal)
        inviteButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        inviteButton.setTitleColor(UIColor(named: "rosentalBlue"), for: .normal)
        
        buttonsStack.translatesAutoresizingMaskIntoConstraints = false
        buttonsStack.axis = .vertical
        buttonsStack.distribution = .fillEqually
        buttonsStack.spacing = 8
        buttonsStack.addArrangedSubview(entryButton)
        buttonsStack.addArrangedSubview(registrationButton)
        buttonsStack.addArrangedSubview(inviteButton)
    }
    
    private func setupLayout() {
        view.addSubview(logoImageView)
        view.addSubview(rosentalLabel)
        view.addSubview(backgroundImageView)
        view.addSubview(greetingLabel)
        view.addSubview(subLabel)
        view.addSubview(buttonsStack)
        
        NSLayoutConstraint.activate([
            logoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            logoImageView.heightAnchor.constraint(equalToConstant: 70),
            logoImageView.widthAnchor.constraint(equalToConstant: 70),
            
            rosentalLabel.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: 8),
            rosentalLabel.topAnchor.constraint(equalTo: logoImageView.topAnchor),
            rosentalLabel.bottomAnchor.constraint(equalTo: logoImageView.bottomAnchor),
            rosentalLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            backgroundImageView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 24),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -180),
            backgroundImageView.heightAnchor.constraint(equalToConstant: 300),
            
            greetingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            greetingLabel.topAnchor.constraint(equalTo: backgroundImageView.bottomAnchor, constant: -16),
            greetingLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            
            subLabel.topAnchor.constraint(equalTo: greetingLabel.bottomAnchor, constant: 16),
            subLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            subLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            
            buttonsStack.heightAnchor.constraint(equalToConstant: 200),
            buttonsStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            buttonsStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            buttonsStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    @objc private func tapEntryButton() {
        let viewController = AuthViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
}
