//
//  AdressInfoView.swift
//  RosentalApp
//
//  Created by Ваня Сокол on 31.08.2024.
//

import UIKit

final class AdressInfoView: UIView {

    private let adressLabel = UILabel()
    private let chevronButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setupUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        adressLabel.text = "ул. Санитарная 7, кв. 179"
        adressLabel.font = UIFont.systemFont(ofSize: 14)
        adressLabel.textAlignment = .left
        adressLabel.textColor = .systemBackground
        
        chevronButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        chevronButton.tintColor = .systemBackground
    }
    
    private func setupLayout() {
        addSubview(adressLabel)
        addSubview(chevronButton)
        
        adressLabel.translatesAutoresizingMaskIntoConstraints = false
        chevronButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            adressLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            adressLabel.topAnchor.constraint(equalTo: topAnchor),
            adressLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            chevronButton.leadingAnchor.constraint(equalTo: adressLabel.trailingAnchor, constant: 6),
            chevronButton.topAnchor.constraint(equalTo: topAnchor, constant: 3),
            chevronButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -3),
        ])
    }
    
    public func configure(with model: MyProfile) {
        adressLabel.text = model.address
    }
}
