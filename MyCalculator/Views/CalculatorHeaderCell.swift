//
//  CalculatorHeaderCell.swift
//  MyCalculator
//
//  Created by Denis Haritonenko on 13.06.24.
//

import UIKit

class CalculatorHeaderCell: UICollectionReusableView {
    
    static let identifier = "CalculatorHeaderCell"
        
    // MARK: - Subviews
    private let numberLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 41, weight: .regular)
        label.text = "Error"
        return label
    }()
    
    private let resultLabel: UILabel = {
        let label = UILabel()
        label.textColor = .calculatorResult
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 41, weight: .regular)
        label.text = "Error"
        return label
    }()
    
    private let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .calculatorLine
        return view
    }()
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(currentNumberText: String, currentResultText: String) {
        self.numberLabel.text = currentNumberText
        self.resultLabel.text = currentResultText
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        self.backgroundColor = .black
        
        self.addSubview(numberLabel)
        self.addSubview(resultLabel)
        self.addSubview(lineView)
        
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        lineView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            numberLabel.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor, constant: 40),
            numberLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            numberLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            resultLabel.topAnchor.constraint(equalTo: numberLabel.bottomAnchor, constant: 40),
            resultLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            resultLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            lineView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15),
            lineView.heightAnchor.constraint(equalToConstant: 1),
            lineView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            lineView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
        ])
    }
}
