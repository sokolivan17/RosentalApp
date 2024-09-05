//
//  NotificationButton.swift
//  RosentalApp
//
//  Created by Ваня Сокол on 31.08.2024.
//

import UIKit

final class NotificationButton: UIButton {

    private let countLabel = UILabel()
    private let buttonImageView = UIImageView()
    private let container = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)

        setupUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        countLabel.text = "4"
        countLabel.font = UIFont.systemFont(ofSize: 8)
        countLabel.textAlignment = .center
        countLabel.textColor = .systemBackground
        
        container.backgroundColor = .systemRed
        container.layer.cornerRadius = 8
        
        buttonImageView.image = UIImage(systemName: "bell")
        buttonImageView.tintColor = .systemBackground
    }
    
    private func setupLayout() {
        addSubview(buttonImageView)
        addSubview(container)
        addSubview(countLabel)
        
        buttonImageView.translatesAutoresizingMaskIntoConstraints = false
        container.translatesAutoresizingMaskIntoConstraints = false
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: topAnchor),
            container.trailingAnchor.constraint(equalTo: trailingAnchor),
            container.widthAnchor.constraint(equalToConstant: 16),
            container.heightAnchor.constraint(equalToConstant: 16),
            
            countLabel.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            countLabel.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            
            buttonImageView.topAnchor.constraint(equalTo: container.bottomAnchor, constant: -8),
            buttonImageView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: 3),
            buttonImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            buttonImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    public func configure(with model: ProfileModel) {
        if model.myNewNotifications == 0 {
            countLabel.isHidden = true
            container.isHidden = true
        } else {
            countLabel.isHidden = false
            container.isHidden = false
            countLabel.text = String(model.myNewNotifications)
        }
    }
}
