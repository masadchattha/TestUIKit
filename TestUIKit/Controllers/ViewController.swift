//
//  ViewController.swift
//  TestUIKit
//
//  Created by Coder Crew on 01/06/2023.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var helloWorldLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalLabel: UILabel!
    
    // MARK: - Constants
    static let identifier = "ViewController"
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    // MARK: - Variables
    var items = [
        CartItem(name: "Item 1", price: 10.0),
        CartItem(name: "Item 2", price: 10.0),
        CartItem(name: "Item 3", price: 10.0),
        CartItem(name: "Item 4", price: 10.0),
        CartItem(name: "Item 5", price: 10.0),
        CartItem(name: "Item 6", price: 10.0),
        CartItem(name: "Item 7", price: 10.0),
        CartItem(name: "Item 8", price: 10.0),
        CartItem(name: "Item 9", price: 5.0),
        CartItem(name: "Item 10", price: 15.0),
    ]
    
    // MARK: - Life Cycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let buttonTitle = NSLocalizedString("Hello", comment: "Greeting ")
        print(buttonTitle)
        registerTableCells()
    }
    
    // MARK: - Objc Functinos
    
    // MARK: - Actions
}

// MARK: - Setup Functions
extension ViewController {
    private func registerTableCells() {
        tableView.register(UINib(nibName: TestTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: TestTableViewCell.identifier)
    }
}

// MARK: - Helper Functions
extension ViewController {
    private func calculateTotal() {
        var totalPrice = 0.0
        for item in items {
            totalPrice += item.subTotal
        }
        // Update UI
        totalLabel.text = "Total: \(totalPrice)"
    }
}

// MARK: - TableView Delegate & Datasource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TestTableViewCell.identifier, for: indexPath) as! TestTableViewCell
        cell.delegate = self // Setting cell as Delegate
        cell.item = items[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
}

// MARK: - TableView Delegate
extension ViewController: CustomCellDelegate {
    func stepperButtonValueChanged(_ cell: TestTableViewCell) {
        guard let index = tableView.indexPath(for: cell) else { return }
        items[index.row].quantity = cell.count
        calculateTotal()
    }
}

// MARK: - Structs
struct CartItem {
    var name: String
    var price: Double
    var quantity: Int?
    var subTotal: Double {
        return Double(quantity ?? 0) * price
    }
}
