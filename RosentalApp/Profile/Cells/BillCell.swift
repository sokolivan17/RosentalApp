//
//  BillCell.swift
//  RosentalApp
//
//  Created by Ваня Сокол on 02.09.2024.
//

import UIKit

final class BillCell: UICollectionViewCell {
    
    static let reuseID = "BillCell"
    
    private let billNameLabel = UILabel()
    private let billDateLabel = UILabel()
    private let billImageView = UIImageView()
    private let meterImageView = UIImageView()
    private let indicationImageView = UIImageView()
    private let priceLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        backgroundColor = .white
        
        billImageView.image = UIImage(named: "rent")
        billImageView.layer.cornerRadius = 25
        billImageView.clipsToBounds = true
        
        billNameLabel.text = "Квартплата"
        billNameLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        
        billDateLabel.text =  "Оплатить до 15 апреля"
        billDateLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        billDateLabel.textColor = .secondaryLabel
        
        meterImageView.image = UIImage(named: "meters")
        meterImageView.contentMode = .scaleAspectFit
        meterImageView.clipsToBounds = true
        
        let firstAttributes = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20, weight: .bold), NSAttributedString.Key.foregroundColor : UIColor.black]
        let secondAttributes = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20, weight: .bold), NSAttributedString.Key.foregroundColor : UIColor.lightGray]
        
        let firstAttributedString = NSMutableAttributedString(string:"4524", attributes: firstAttributes)
        let secondAttributedString = NSMutableAttributedString(string:",43 ₽", attributes: secondAttributes)
        
        firstAttributedString.append(secondAttributedString)
        priceLabel.attributedText = firstAttributedString
    }
    
    private func setupLayout() {
        let views = [
            billNameLabel,
            billImageView,
            billDateLabel,
            priceLabel,
            meterImageView
        ]
        
        views.forEach { item in
            addSubview(item)
            item.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            billImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            billImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            billImageView.heightAnchor.constraint(equalToConstant: 50),
            billImageView.widthAnchor.constraint(equalToConstant: 50),
            
            billNameLabel.topAnchor.constraint(equalTo: billImageView.topAnchor),
            billNameLabel.leadingAnchor.constraint(equalTo: billImageView.trailingAnchor, constant: 8),
            
            billDateLabel.topAnchor.constraint(equalTo: billNameLabel.bottomAnchor, constant: 4),
            billDateLabel.leadingAnchor.constraint(equalTo: billImageView.trailingAnchor, constant: 8),
            
            priceLabel.topAnchor.constraint(equalTo: billImageView.topAnchor),
            priceLabel.leadingAnchor.constraint(equalTo: billNameLabel.trailingAnchor, constant: 8),
            priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            
            meterImageView.topAnchor.constraint(equalTo: billImageView.topAnchor),
            meterImageView.widthAnchor.constraint(equalToConstant: 70),
            meterImageView.heightAnchor.constraint(equalToConstant: 20),
            meterImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
        ])
    }
    
    public func configure(with model: MenuItems?) {
        billNameLabel.text = model?.name
        billDateLabel.text = model?.description
        
        if model?.action == "payment" {
            priceLabel.isHidden = false
            meterImageView.isHidden = true
            
            let separatedArray = model?.arrear?.components(separatedBy: ".")
            let firstString = separatedArray?[0] ?? ""
            let secondString = "," + (separatedArray?[1] ?? "") + " ₽"
            
            let firstAttributes = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20, weight: .bold), NSAttributedString.Key.foregroundColor : UIColor.black]
            let secondAttributes = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20, weight: .bold), NSAttributedString.Key.foregroundColor : UIColor.lightGray]
            
            let firstAttributedString = NSMutableAttributedString(string: firstString, attributes: firstAttributes)
            let secondAttributedString = NSMutableAttributedString(string: secondString, attributes: secondAttributes)
            
            firstAttributedString.append(secondAttributedString)
            priceLabel.attributedText = firstAttributedString
        } else if model?.action == "meters" {
            priceLabel.isHidden = true
            meterImageView.isHidden = false
        } else {
            priceLabel.isHidden = true
            meterImageView.isHidden = true
        }
    }
}
