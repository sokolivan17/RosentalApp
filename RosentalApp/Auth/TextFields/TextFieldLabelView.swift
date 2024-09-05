//
//  TextFieldLabelView.swift
//  RosentalApp
//
//  Created by Ваня Сокол on 04.09.2024.
//

import UIKit

final class TextFieldLabelView: UIView {
    
    private let textFieldLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(with text: String) {
        self.init(frame: .zero)
        textFieldLabel.text = text
    }
    
    private func setupUI() {
        backgroundColor = .white
        
        textFieldLabel.textColor = UIColor(named: "textFieldGray")
        textFieldLabel.font = UIFont.systemFont(ofSize: 14)
    }
    
    private func setupLayout() {
        addSubview(textFieldLabel)
        textFieldLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textFieldLabel.topAnchor.constraint(equalTo: topAnchor),
            textFieldLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            textFieldLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
            textFieldLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
