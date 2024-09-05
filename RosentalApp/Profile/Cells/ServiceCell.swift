//
//  ServiceCell.swift
//  RosentalApp
//
//  Created by Ваня Сокол on 02.09.2024.
//

import UIKit

final class ServiceCell: UICollectionViewCell {
    
    static let reuseID = "ServiceCell"
    
    private let containerView = UIView()
    private let serviceNameLabel = UILabel()
    private let serviceImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        containerView.backgroundColor = UIColor(named: "rosentalGray")
        containerView.layer.cornerRadius = 10
        
        serviceImageView.image = UIImage(named: "barrier")
        serviceImageView.layer.cornerRadius = 25
        serviceImageView.contentMode = .scaleAspectFit
        serviceImageView.clipsToBounds = true
        
        serviceNameLabel.text = "Камеры"
        serviceNameLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        serviceNameLabel.textAlignment = .center
    }
    
    private func setupLayout() {
        addSubview(containerView)
        containerView.addSubview(serviceNameLabel)
        containerView.addSubview(serviceImageView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        serviceImageView.translatesAutoresizingMaskIntoConstraints = false
        serviceNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            serviceImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            serviceImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 18),
            serviceImageView.heightAnchor.constraint(equalToConstant: 50),
            serviceImageView.widthAnchor.constraint(equalToConstant: 50),
            
            serviceNameLabel.topAnchor.constraint(equalTo: serviceImageView.bottomAnchor, constant: 10),
            serviceNameLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            serviceNameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 4),
            serviceNameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -4)
        ])
    }
    
    public func configure(with model: Services?) {
        serviceNameLabel.text = model?.name ?? "Камеры"
    }
}
