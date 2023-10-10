//
//  PaymentVC.swift
//  TestUIKit
//
//  Created by Coder Crew on 04/08/2023.
//

import UIKit

class PaymentVC: UIViewController {
    
    // MARK: - Outlets
    
    // MARK: - Constants/Variables
    static let identifier = "PaymentVC"
    var items1 = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48"]
    var items = ["BRONZE", "SILVER", "GOLD"]
    
    // MARK: - Life Cycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: - Objc Functions
    
    // MARK: - Actions

}

// MARK: - Helper Functions
extension PaymentVC {
    
}

// MARK: - CollectionView Datasource & Delegate
extension PaymentVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCollectionViewCell.identifier, for: indexPath as IndexPath) as! MyCollectionViewCell
        
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        cell.label.text = self.items[indexPath.row] // The row value is the same as the index of the desired text within the array.
//        cell.backgroundColor = UIColor.cyan // make cell more visible in our example project
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
}
