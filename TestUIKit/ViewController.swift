//
//  ViewController.swift
//  TestUIKit
//
//  Created by Coder Crew on 01/06/2023.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Outlets
    
    // MARK: - Constants/Variables
    static let identifier = "ViewController"
    
    // MARK: - Life Cycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Objc Functinos
    
    
    // MARK: - Actions
    @IBAction func purchaseButtonTapped(_ sender: UIButton) {
        let story = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = story.instantiateViewController(withIdentifier: PaymentVC.identifier) as? PaymentVC else {return}
        vc.modalTransitionStyle  = .crossDissolve
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true, completion: nil)
    }
}

// MARK: - Setup Functions
extension ViewController {
    
}

// MARK: - Helper Functions
extension ViewController {
    
}

// MARK: - Collection View
extension ViewController {
    
    
}



