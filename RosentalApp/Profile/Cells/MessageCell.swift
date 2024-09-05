//
//  MessageCell.swift
//  RosentalApp
//
//  Created by Ваня Сокол on 02.09.2024.
//

import UIKit

final class MessageCell: UICollectionViewCell {
    
    static let reuseID = "MessageCell"
    
    private let containerView = UIView()
    private let messageLabel = UILabel()
    private let notificationMarkView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 6
        containerView.layer.shadowRadius = 4
        containerView.layer.shadowColor = UIColor.lightGray.cgColor
        containerView.layer.shadowOffset = .zero
        containerView.layer.shadowOpacity = 1
        
        notificationMarkView.backgroundColor = .systemRed
        notificationMarkView.layer.cornerRadius = 4
        
        messageLabel.text = "2 сообщения от УК"
        messageLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
    }
    
    private func setupLayout() {
        addSubview(containerView)
        containerView.addSubview(messageLabel)
        containerView.addSubview(notificationMarkView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        notificationMarkView.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            messageLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            messageLabel.trailingAnchor.constraint(equalTo: notificationMarkView.leadingAnchor, constant: -8),
            
            notificationMarkView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            notificationMarkView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            notificationMarkView.heightAnchor.constraint(equalToConstant: 8),
            notificationMarkView.widthAnchor.constraint(equalToConstant: 8)
        ])
    }
    
    public func configure(with model: Notifications?) {
        let count = String(model?.count ?? 2)
        messageLabel.text = "\(count) сообщения от УК"
    }
}
