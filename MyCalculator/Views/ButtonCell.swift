//
//  ButtonCell.swift
//  MyCalculator
//
//  Created by Denis Haritonenko on 13.06.24.
//

import UIKit

class ButtonCell: UICollectionViewCell {
    
    static let identifier = "ButtonCell"
    
    private(set) var calculatorButton: CalculatorButton!
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 36, weight: .regular)
        label.text = "Error"
        return label
    }()
    
    public func configure(with calculatorButton: CalculatorButton) {
        self.calculatorButton = calculatorButton
        
        self.titleLabel.text = calculatorButton.title
        self.backgroundColor = calculatorButton.color
        self.titleLabel.textColor = calculatorButton.textColor
        
        self.setupUI()
    }
    
    private func setupUI() {
        
        self.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.layer.cornerRadius = 9
        
        NSLayoutConstraint.activate([
            self.titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.titleLabel.heightAnchor.constraint(equalTo: self.heightAnchor),
            self.titleLabel.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.titleLabel.removeFromSuperview()
    }
}
