//
//  ViewController.swift
//  TestUIKit
//
//  Created by Coder Crew on 01/06/2023.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    let linkedAccounts = [
        Account(name: "Lorem Ipsum", mobileNumber: "+1 456 5555 1212", email: "loremipsum@gmail.com"),
        Account(name: "Lorem Ipsum", mobileNumber: "+1 456 5555 1212", email: "loremipsum@gmail.com")
    ]
    
    // MARK: - Constants/Variables
    static let identifier = "ViewController"
    
    // MARK: - Life Cycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register Cell with TableView
        registerCell()
    }
    
    // MARK: - Objc Functinos
    @objc func removeAccountButtonTapped() {
        print("Account Removed")
    }


    // MARK: - Actions

}

// MARK: - Setup Functions
extension ViewController {
    func registerCell() {
        tableView.register(UINib(nibName: LinkedAccountsTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: LinkedAccountsTableViewCell.identifier)
    }
}

// MARK: - Helper Functions
extension ViewController {
    
}

// MARK: - TableView DataSource and Delegate
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        linkedAccounts.count
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LinkedAccountsTableViewCell.identifier, for: indexPath) as! LinkedAccountsTableViewCell
        cell.nameLabel.text = linkedAccounts[indexPath.row].name
        cell.mobileNumberLabel.text = linkedAccounts[indexPath.row].mobileNumber
        cell.emailLabel.text = linkedAccounts[indexPath.row].email
        cell.removeButton.addTarget(self, action: #selector(removeAccountButtonTapped), for: .touchUpInside)
//        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print("Tapped on Account name: \(linkedAccounts[indexPath.row].name)")
    }
    
    
}

// MARK: - Account Model
struct Account {
    let name: String
    let mobileNumber: String
    let email: String
}



