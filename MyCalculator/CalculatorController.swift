//
//  ViewController.swift
//  MyCalculator
//
//  Created by Denis Haritonenko on 10.06.24.
//

import UIKit

class CalculatorController: UIViewController {
    // MARK: - Variables
    let viewModel: CalculatorControllerViewModel
    
    // MARK: - Subviews
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .black
        collectionView.register(CalculatorHeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CalculatorHeaderCell.identifier)
        collectionView.register(ButtonCell.self, forCellWithReuseIdentifier: ButtonCell.identifier)
        return collectionView
    }()
    
    // MARK: - Life Cycle
    init(_ viewModel: CalculatorControllerViewModel = CalculatorControllerViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil) //????
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGreen
        
        setupUI()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.viewModel.updateViews = { [weak self] in
            DispatchQueue.main.async { [weak self] in
                self?.collectionView.reloadData()
            }
        }
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = .red
        
        self.view.addSubview(self.collectionView)
        
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
}


extension CalculatorController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // Sections
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CalculatorHeaderCell.identifier, for: indexPath) as? CalculatorHeaderCell else {
            fatalError("Failed to dequeue Header")
        }
        header.configure(currentCalcText: self.viewModel.calcHeaderLabel)
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let totalCellHeight = (view.frame.size.width - 100) / 4 * 5
        let totalVerticalCellSpacing = CGFloat(20*4)
        
        // Find Screen Heigth
        let window = view.window?.windowScene?.keyWindow
        let topPadding = window?.safeAreaInsets.top ?? 0
        let bottomPadding = window?.safeAreaInsets.bottom ?? 0
        let availableScreenHeight = view.frame.size.height - topPadding - bottomPadding
        
        let headerHeight = (availableScreenHeight - totalCellHeight) - totalVerticalCellSpacing
        return CGSize(width: view.frame.size.width, height: headerHeight)
    }
    
    // Buttons
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.calculatorButtonCells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ButtonCell.identifier, for: indexPath) as? ButtonCell else {
            fatalError("Failed to dequeue cell")
        }
        let calculatorButton = self.viewModel.calculatorButtonCells[indexPath.row]
        cell.configure(with: calculatorButton)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellSize = (view.frame.size.width - 100) / 4
        
        let calculatorButton = self.viewModel.calculatorButtonCells[indexPath.row]
        switch calculatorButton {
        case .equals:
            return CGSize(
                width: cellSize * 2 + 20,
                height: cellSize
            )
        default:
            return CGSize(width: cellSize, height: cellSize)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
        
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let buttonCell = self.viewModel.calculatorButtonCells[indexPath.row]
        print(buttonCell.title)
        self.viewModel.didSelectButton(with: buttonCell)
    }
    
}
