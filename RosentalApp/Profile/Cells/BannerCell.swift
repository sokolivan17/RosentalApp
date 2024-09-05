//
//  BannerCell.swift
//  RosentalApp
//
//  Created by Ваня Сокол on 02.09.2024.
//

import UIKit

final class BannerCell: UICollectionViewCell {
    
    static let reuseID = "BannerCell"
    
    private let containerView = UIView()
    private let bannerNameLabel = UILabel()
    private let bannerSubLabel = UILabel()
    private let bannerImageView = UIImageView()
    
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
        containerView.layer.cornerRadius = 8
        containerView.layer.shadowRadius = 4
        containerView.layer.shadowColor = UIColor.lightGray.cgColor
        containerView.layer.shadowOffset = .zero
        containerView.layer.shadowOpacity = 1
        
        bannerImageView.image = UIImage(named: "banner")
        bannerImageView.contentMode = .scaleAspectFit
        bannerImageView.clipsToBounds = true
        
        bannerNameLabel.text = "Страхование"
        bannerNameLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        
        bannerSubLabel.text =  "Защитим имущество и здоровье"
        bannerSubLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        bannerSubLabel.textColor = .secondaryLabel
    }
    
    private func setupLayout() {
        addSubview(containerView)
        containerView.addSubview(bannerNameLabel)
        containerView.addSubview(bannerImageView)
        containerView.addSubview(bannerSubLabel)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        bannerImageView.translatesAutoresizingMaskIntoConstraints = false
        bannerNameLabel.translatesAutoresizingMaskIntoConstraints = false
        bannerSubLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            
            bannerImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            bannerImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            bannerImageView.heightAnchor.constraint(equalToConstant: 50),
            bannerImageView.widthAnchor.constraint(equalToConstant: 50),
            
            bannerNameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 14),
            bannerNameLabel.leadingAnchor.constraint(equalTo: bannerImageView.trailingAnchor, constant: 8),
            bannerNameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            
            bannerSubLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -14),
            bannerSubLabel.leadingAnchor.constraint(equalTo: bannerImageView.trailingAnchor, constant: 8),
            bannerSubLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8)
        ])
    }
    
    public func configure(with model: Banners?) {
        guard let model else { return }
        
        NetworkService.shared.downloadImage(fromURL: model.image) { [weak self] image in
            guard let self else { return }
            self.bannerImageView.image = image
        }
        
        bannerNameLabel.text = model.title
        bannerSubLabel.text = model.text
    }
}
