//
//  AddTransactionViewController.swift
//  MyWallet
//
//  Created by Macbook Air on 21.09.2022.
//

import UIKit

class AddTransactionViewController: UIViewController {
    
    private let dataService = DataService.shared
    private let category: [String] = ["Taxi", "Food"]
    private var selectedCategory = String()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.setupLabel(fontName: .semiBold, text: "Transaction", textSize: 24, color: .blackColor)
        return label
    }()
    
    private let amountStack: UIStackView = {
        let stackView = UIStackView()
        stackView.setupStackView(axis: .vertical, spacing: 10)
        return stackView
    }()
    
    private let amountLabel: UILabel = {
        let label = UILabel()
        label.setupLabel(fontName: .regular, text: "Amount:", textSize: 16, color: .blackColor)
        return label
    }()
    
    private let enterAmountTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter amount"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .decimalPad
        textField.addDoneCancelToolbar()
        return textField
    }()
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.setupLabel(fontName: .regular, text: "Category:", textSize: 16, color: .blackColor)
        return label
    }()
    
    private let categoryList: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isScrollEnabled = false
        return tableView
    }()
    
    private let addButton: UIButton = {
        let button = UIButton()
        button.setupButton(title: "Add", fontName: .medium, backgroundColor: .nightRiderColor, titleColor: .whiteColor)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInterface()
        setConstraints()
        addButton.addTarget(self, action: #selector(addTransaction), for: .touchUpInside)
    }
    
    @objc private func addTransaction() {
        guard let inputAmount = Double(enterAmountTextField.text?.replacingOccurrences(of: ",", with: ".") ?? "") else { return setAlert() }
        guard let currentDate = Date().getCurrentDate(format: .dateWithTime) else { return }
        let dif = self.dataService.fetchedAmount() - inputAmount
        if inputAmount == 0 || selectedCategory == "" {
            setAlert()
        } else {
            dataService.saveAmount(currentBalance: dif, amount: inputAmount, date: currentDate, category: selectedCategory)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    private func setAlert() {
        let alertController = UIAlertController(title: "Ooops", message: "You should fill all fields", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .destructive)
        alertController.addAction(action)
        present(alertController, animated: true)
    }
    
    private func setInterface() {
        view.backgroundColor = UIColor(rgb: 0xFFFFFF)
        view.addSubview(titleLabel)
        view.addSubview(amountStack)
        view.addSubview(categoryLabel)
        view.addSubview(categoryList)
        view.addSubview(addButton)
        amountStack.addArrangedSubview(amountLabel)
        amountStack.addArrangedSubview(enterAmountTextField)
        categoryList.dataSource = self
        categoryList.delegate = self
        categoryList.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    private func setConstraints() {
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 36).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        amountStack.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 212).isActive = true
        amountStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        amountStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        
        enterAmountTextField.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        categoryLabel.topAnchor.constraint(equalTo: enterAmountTextField.bottomAnchor, constant: 20).isActive = true
        categoryLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        categoryLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        
        categoryList.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 8).isActive = true
        categoryList.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        categoryList.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        categoryList.bottomAnchor.constraint(equalTo: addButton.topAnchor, constant: 40).isActive = true
        
        addButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        addButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -174).isActive = true
    }
    
    
}

extension AddTransactionViewController: UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return category.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = category[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let category = tableView.cellForRow(at: indexPath)?.textLabel?.text else { return }
        selectedCategory = category
    }
    
}
