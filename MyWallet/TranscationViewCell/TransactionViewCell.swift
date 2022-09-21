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
        icon.image = UIImage(named: "topUpIcon")
        icon.contentMode = .scaleAspectFit
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    
    private let categoryStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let typeOfSpentLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(rgb: 0x000000)
        label.font = UIFont(name: "Montserrat-Regular", size: 16)
        label.text = "Terminal"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let categoryNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(rgb: 0x9D9D9D)
        label.font = UIFont(name: "Montserrat-Regular", size: 12)
        label.text = "Payment"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let infoStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let spentAmountLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(rgb: 0x21C531)
        label.font = UIFont(name: "Montserrat-Regular", size: 16)
        label.text = "+30 BTC"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = UIColor(rgb: 0x9D9D9D)
        label.font = UIFont(name: "Montserrat-Regular", size: 12)
        label.text = "12:37"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
    func configureView(date: String, amount: Int64) {
        spentAmountLabel.text = "+\(amount) BTC"
        dateLabel.text = "\(date.toDay())"
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
