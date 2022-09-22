//
//  TransactionViewCell.swift
//  MyWallet
//
//  Created by Macbook Air on 21.09.2022.
//

import UIKit

class TransactionViewCell: UITableViewCell {
    
    static let identifier = "CategoryCell"
    
    private let iconCategoryImage: UIImageView = {
        let icon = UIImageView()
        icon.contentMode = .scaleAspectFit
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    
    private let categoryStack: UIStackView = {
        let stackView = UIStackView()
        stackView.setupStackView(axis: .vertical, spacing: 5)
        return stackView
    }()
    
    private let typeOfSpentLabel: UILabel = {
        let label = UILabel()
        label.setupLabel(fontName: .regular, text: nil, textSize: 16, color: .blackColor)
        return label
    }()
    
    private let categoryNameLabel: UILabel = {
        let label = UILabel()
        label.setupLabel(fontName: .regular, text: nil, textSize: 12, color: .nobelColor)
        return label
    }()
    
    private let infoStack: UIStackView = {
        let stackView = UIStackView()
        stackView.setupStackView(axis: .vertical, spacing: 5)
        return stackView
    }()
    
    private let spentAmountLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.setupLabel(fontName: .regular, text: nil, textSize: 12, color: .nobelColor)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupView() {
        contentView.addSubview(iconCategoryImage)
        contentView.addSubview(categoryStack)
        contentView.addSubview(infoStack)
        categoryStack.addArrangedSubview(typeOfSpentLabel)
        categoryStack.addArrangedSubview(categoryNameLabel)
        infoStack.addArrangedSubview(spentAmountLabel)
        infoStack.addArrangedSubview(dateLabel)
    }
    
    private func setupConstraints() {
        iconCategoryImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        iconCategoryImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        iconCategoryImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
        iconCategoryImage.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 1.0/1.0).isActive = true
        
        categoryStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
        categoryStack.leadingAnchor.constraint(equalTo: iconCategoryImage.trailingAnchor, constant: 16).isActive = true
        categoryStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16).isActive = true
        
        infoStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
        infoStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        infoStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16).isActive = true
    }
    
    func configureView(date: String, amount: Double, category: String) {
        dateLabel.text = "\(date.toDay(format: .hoursWithMinutes))"
        categoryNameLabel.text = categoryType(category: category)
        typeOfSpentLabel.text = organizationName(category: category)
        iconCategoryImage.image = UIImage(named: getIcon(category: category))
        spentAmountLabel.setupLabel(fontName: .regular, text: "\(amount) BTC", textSize: 16, color: spentColor(category: category))
    }
    
    private func getIcon(category: String) -> String {
        guard let categoryType = CategoryType(rawValue: category) else { return "topUpIcon" }
        return categoryType.getIcon()
    }
    
    private func spentColor(category: String) -> Color {
        guard let categoryType = CategoryType(rawValue: category) else { return .limeColor }
        return categoryType.spentColor()
    }
    
    private func categoryType(category: String) -> String {
        guard let categoryType = CategoryType(rawValue: category) else { return "" }
        return categoryType.getType()
    }
    
    private func organizationName(category: String) -> String {
        guard let categoryType = CategoryType(rawValue: category) else { return "" }
        return categoryType.getName()
    }

}

enum CategoryType: String {
    case topUp = "TopUp"
    case taxi = "Taxi"
    case food = "Food"
    
    func getType() -> String {
        switch self {
        case .topUp:
            return "Payment"
        case .taxi:
            return "Taxi"
        case .food:
            return "Food"
        }
    }
    
    func getName() -> String {
        switch self {
        case .topUp:
            return "Terminal"
        case .taxi:
            return "Uber"
        case .food:
            return "McDonald's"
        }
    }
    
    func transactionType(amount: Double) -> Double {
        switch self {
        case .topUp:
            return amount
        case .taxi:
            return -amount
        case .food:
            return -amount
        }
    }
    
    func spentColor() -> Color {
        switch self {
        case .topUp:
            return Color.limeColor
        case .taxi:
            return Color.redColor
        case .food:
            return Color.redColor
        }
    }
    
    func getIcon() -> String {
        switch self {
        case .topUp:
            return "topUpIcon"
        case .taxi:
            return "taxiIcon"
        case .food:
            return "foodIcon"
        }
    }
}


