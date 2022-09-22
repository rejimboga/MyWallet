//
//  HomeViewController.swift
//  MyWallet
//
//  Created by Macbook Air on 16.09.2022.
//

import UIKit
import CoreData

class HomeViewController: UIViewController, NSFetchedResultsControllerDelegate, UIScrollViewDelegate {
    
    private let dataService = DataService.shared
    private var page: Int = 1
    private var fetchedPayment: NSFetchedResultsController<Payment>?
    
    private let bitcoinImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "bitcoinImage")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let currencyLabel: UILabel = {
        let label = UILabel()
        label.setupLabel(fontName: .regular, text: nil, textSize: 12, color: .whiteColor)
        return label
    }()
    
    private let balanceStack: UIStackView = {
        let stackView = UIStackView()
        stackView.setupStackView(axis: .vertical, spacing: 10)
        return stackView
    }()
    
    private let balanceLabel: UILabel = {
        let label = UILabel()
        label.setupLabel(fontName: .regular, text: "Balance BTC", textSize: 16, color: .whiteColor)
        return label
    }()
    
    private let amountLabel: UILabel = {
        let label = UILabel()
        label.setupLabel(fontName: .semiBold, text: nil, textSize: 32, color: .whiteColor)
        return label
    }()
    
    private let depositButton: UIButton = {
        let button = UIButton(type: .system)
        button.setupButton(title: "Deposit", fontName: .medium, backgroundColor: .whiteColor, titleColor: .blackColor)
        return button
    }()
    
    private let addTransactionButton: UIButton = {
        let button = UIButton(type: .system)
        button.setupButton(title: "Add transaction", fontName: .medium, backgroundColor: .whiteColor, titleColor: .blackColor)
        return button
    }()
    
    private let transactionHistory: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.amountLabel.text = "\(dataService.fetchedAmount())"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInterface()
        setConstraints()
        depositButton.addTarget(self, action: #selector(deposit), for: .touchUpInside)
        addTransactionButton.addTarget(self, action: #selector(addNewTransaction), for: .touchUpInside)
        networkRequest()
        fetchData()
    }
    
    //MARK: - scrollViewDidEndDragging
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let position = scrollView.contentOffset.y
        if position > (transactionHistory.contentSize.height - 100 - scrollView.frame.size.height) {
            fetchData()
        }
    }
    
    //MARK: - Functions & Actions
    @objc private func deposit() {
        setAlert()
    }
    
    @objc private func addNewTransaction() {
        self.show(AddTransactionViewController(), sender: self)
    }
    
    private func networkRequest() {
        NetworkRequest.shared.getCurrency { [weak self] results in
            switch results {
            case .success(let result):
                self?.currencyLabel.text = "(BTC) $\(result.rateFloat ?? 0.0)"
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }
    
    private func fetchData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest : NSFetchRequest<Payment> = Payment.fetchRequest()
        fetchRequest.fetchBatchSize = 20
        fetchRequest.fetchLimit = page * 20
        let mySortDescriptor = NSSortDescriptor(key: #keyPath(Payment.date), ascending: false)
        fetchRequest.sortDescriptors = [mySortDescriptor]
        fetchedPayment = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: #keyPath(Payment.currentDate), cacheName: nil)
        fetchedPayment?.delegate = self
        do {
            try fetchedPayment?.performFetch()
            page += 1
            transactionHistory.reloadData()
        } catch {
            print("Couldn't fetch")
        }
    }
    
    private func setAlert() {
        let alertController = UIAlertController(title: "Deposit", message: "Enter the amount", preferredStyle: .alert)

        alertController.addTextField { (textField) in
            textField.keyboardType = .decimalPad
            textField.placeholder = "Amount"
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            guard let inputAmount = Double(alertController.textFields?.first?.text?.replacingOccurrences(of: ",", with: ".") ?? "") else { return }
            guard let currentDate = Date().getCurrentDate(format: .dateWithTime) else { return }
            let sum = self.dataService.fetchedAmount() + inputAmount
            let topUpCategory = "TopUp"
            self.dataService.saveAmount(currentBalance: sum, amount: inputAmount, date: currentDate, category: topUpCategory)
            self.amountLabel.text = "\(sum)"
            self.transactionHistory.reloadData()
        }

        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)

        present(alertController, animated: true, completion: nil)
    }
    
    //MARK: - Setup interface
    private func setInterface() {
        self.navigationController?.navigationBar.isHidden = true
        view.backgroundColor = UIColor(rgb: 0x333333)
        view.addSubview(balanceStack)
        view.addSubview(currencyLabel)
        view.addSubview(bitcoinImage)
        view.addSubview(depositButton)
        view.addSubview(addTransactionButton)
        view.addSubview(transactionHistory)
        balanceStack.addArrangedSubview(balanceLabel)
        balanceStack.addArrangedSubview(amountLabel)
        transactionHistory.dataSource = self
        transactionHistory.delegate = self
        transactionHistory.register(TransactionViewCell.self, forCellReuseIdentifier: TransactionViewCell.identifier)
    }
    
    private func setConstraints() {
        balanceStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 44).isActive = true
        balanceStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12).isActive = true
        balanceStack.trailingAnchor.constraint(equalTo: depositButton.leadingAnchor, constant: -16).isActive = true
        
        currencyLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        currencyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12).isActive = true
        
        bitcoinImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        bitcoinImage.trailingAnchor.constraint(equalTo: currencyLabel.leadingAnchor, constant: -4).isActive = true

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
    
    //MARK: - NSFetchedResultsControllerDelegate
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        transactionHistory.reloadData()
    }
    
}

//MARK: - UITableView delegate & dataSource
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedPayment?.sections?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sectionInfo = fetchedPayment?.sections?[section] else { return 1 }
        return sectionInfo.numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TransactionViewCell.identifier, for: indexPath) as? TransactionViewCell else { return UITableViewCell() }

        guard let transfer = fetchedPayment?.object(at: indexPath) else { return UITableViewCell() }
        cell.configureView(date: transfer.date?.toDayString(format: .dateWithTime) ?? "", amount: transfer.amount, category: transfer.category ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let header = (fetchedPayment?.sections?[section].objects?.first as? Payment)?.date?.toDayString(format: .dayOfMonth)
        return header
    }
    
    
}

extension Payment {
    @objc var currentDate: String {
        get {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            return formatter.string(from: self.date ?? Date())
        }
    }
}
