//
//  CalculatorHeaderCell.swift
//  MyCalculator
//
//  Created by Denis Haritonenko on 13.06.24.
//

import UIKit

class CalculatorHeaderCell: UICollectionReusableView {
    
    static let identifier = "CalculatorHeaderCell"
    
    // MARK: - Variables
    
    // MARK: - Subviews
    private let problemLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 41, weight: .regular)
        label.text = "2+7-(390)"
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
    
    public func configure(currentCalcText: String) {
        self.resultLabel.text = currentCalcText
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        self.backgroundColor = .black
        
        self.addSubview(problemLabel)
        self.addSubview(resultLabel)
        self.addSubview(lineView)
        
        problemLabel.translatesAutoresizingMaskIntoConstraints = false
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        lineView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            problemLabel.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor, constant: 10),
            problemLabel.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            problemLabel.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
            
            resultLabel.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor, constant: -5),
            resultLabel.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            resultLabel.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
            
            lineView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15),
            lineView.heightAnchor.constraint(equalToConstant: 1),
            lineView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            lineView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
        ])
    }
    
    // MARK: - Selectors
    

}
