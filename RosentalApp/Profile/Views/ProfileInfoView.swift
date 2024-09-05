//
//  ProfileInfoView.swift
//  RosentalApp
//
//  Created by Ваня Сокол on 31.08.2024.
//

import UIKit

final class ProfileInfoView: UIView {

    private let nameLabel = UILabel()
    private let iconImageView = UIImageView()
    private let adressView = AdressInfoView()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        nameLabel.text = "Константин П."
        nameLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        nameLabel.textColor = .systemBackground
        
        iconImageView.backgroundColor = .systemBackground
        iconImageView.image = UIImage(systemName: "face.smiling")
        iconImageView.layer.cornerRadius = 15
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.clipsToBounds = true
    }
    
    private func setupLayout() {
        addSubview(nameLabel)
        addSubview(iconImageView)
        addSubview(adressView)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        adressView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint .activate([
            iconImageView.topAnchor.constraint(equalTo: topAnchor),
            iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 30),
            iconImageView.heightAnchor.constraint(equalToConstant: 30),
            
            nameLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 12),
            nameLabel.topAnchor.constraint(equalTo: topAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: iconImageView.bottomAnchor),
            
            adressView.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            adressView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            adressView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    public func configureView(with model: MyProfile) {
        NetworkService.shared.downloadImage(fromURL: model.photo) { [weak self] image in
            guard let self else { return }
            self.iconImageView.image = image
        }
        
        nameLabel.text = model.shortName
        adressView.configure(with: model)
    }
}
