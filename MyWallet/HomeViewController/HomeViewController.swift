//
//  HomeViewController.swift
//  MyWallet
//
//  Created by Macbook Air on 16.09.2022.
//

import UIKit
import CoreData

class HomeViewController: UIViewController {
    
    private var history: [Int64] = []
    
    private let bitcoindImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "bitcoinImage")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let currencyLabel: UILabel = {
        let label = UILabel()
        return label.setLabel(fontName: "Montserrat-Regular", text: nil, textSize: 12)
    }()
    
    private let balanceStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let balanceLabel: UILabel = {
        let label = UILabel()
        return label.setLabel(fontName: "Montserrat-Regular", text: "Balance BTC", textSize: 16)
    }()
    
    private let amountLabel: UILabel = {
        let label = UILabel()
        return label.setLabel(fontName: "Montserrat-SemiBold", text: nil, textSize: 32)
    }()
    
    private let depositButton: UIButton = {
        let button = UIButton(type: .system)
        return button.setButton(title: "Deposit", image: "depositButton", padding: 70)
    }()
    
    private let addTransactionButton: UIButton = {
        let button = UIButton(type: .system)
        return button.setButton(title: "Add transaction", image: "transactionButton", padding: 210)
    }()
    
    private let transactionHistory: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInterface()
        setConstraints()
        depositButton.addTarget(self, action: #selector(deposit), for: .touchUpInside)
        
        NetworkRequest.shared.getCurrency { [weak self] results in
            switch results {
            case .success(let result):
                self?.currencyLabel.text = "(BTC) $\(result.rateFloat ?? 0.0)"
            case .failure(let error):
                print(error)
            }
        }
        
        self.amountLabel.text = "\(DataService().fetchedAmount())"
    }
    
    @objc private func deposit() {
        setAlert()
    }
    
    private func setAlert() {
        let alertController = UIAlertController(title: "Deposit", message: "Enter the amount", preferredStyle: .alert)

        alertController.addTextField { (textField) in
            textField.keyboardType = .numberPad
            textField.placeholder = "Amount"
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            let inputAmount = Int64(alertController.textFields?.first?.text ?? "")
            guard let inputAmount = inputAmount else { return }
            self.saveAmount(amount: inputAmount)
            self.topUpHistory(amount: inputAmount)
            self.amountLabel.text = "\(inputAmount)"
        }

        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)

        present(alertController, animated: true, completion: nil)
    }
    
    private func topUpHistory(amount: Int64) {
        history.append(amount)
        transactionHistory.reloadData()
    }
    
    private func saveAmount(amount: Int64) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: "Balance", in: context) else { return }
        
        let balanceObject = Balance(entity: entity, insertInto: context)
        balanceObject.amount = amount
        do {
            try context.save()
        } catch {
            print("Couldn't save data")
        }
    }

    
    private func setInterface() {
        self.navigationController?.navigationBar.isHidden = true
        view.backgroundColor = UIColor(rgb: 0x333333)
        view.addSubview(balanceStack)
        view.addSubview(currencyLabel)
        view.addSubview(bitcoindImage)
        view.addSubview(depositButton)
        view.addSubview(addTransactionButton)
        view.addSubview(transactionHistory)
        balanceStack.addArrangedSubview(balanceLabel)
        balanceStack.addArrangedSubview(amountLabel)
        transactionHistory.dataSource = self
        transactionHistory.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    private func setConstraints() {
        balanceStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 44).isActive = true
        balanceStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12).isActive = true
        balanceStack.trailingAnchor.constraint(equalTo: depositButton.leadingAnchor, constant: -16).isActive = true
        
        currencyLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        currencyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12).isActive = true
        
        bitcoindImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        bitcoindImage.trailingAnchor.constraint(equalTo: currencyLabel.leadingAnchor, constant: -4).isActive = true

        depositButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12).isActive = true
        depositButton.bottomAnchor.constraint(equalTo: addTransactionButton.topAnchor, constant: -16).isActive = true
        depositButton.widthAnchor.constraint(equalToConstant: 185).isActive = true
        depositButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        addTransactionButton.topAnchor.constraint(equalTo: balanceStack.bottomAnchor, constant: 16).isActive = true
        addTransactionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12).isActive = true
        addTransactionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12).isActive = true
        addTransactionButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        transactionHistory.topAnchor.constraint(equalTo: addTransactionButton.bottomAnchor, constant: 32).isActive = true
        transactionHistory.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        transactionHistory.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        transactionHistory.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return history.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(history[indexPath.row])"
        return cell
    }
    
}
