//
//  TestTableViewCell.swift
//  TestUIKit
//
//  Created by Coder Crew on 09/10/2023.
//

import UIKit

protocol CustomCellDelegate: AnyObject {
    func stepperButtonValueChanged(_ cell: TestTableViewCell)
}

class TestTableViewCell: UITableViewCell {
    
    // MARK: - Static Properties
    static let identifier = "TestTableViewCell"
    
    // MARK: - Outlets Label
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    // MARK: - Outlets Button
    
    // MARK: - Variables
    var count = 0
    var item: CartItem? {
        didSet {
            configureCell()
        }
    }
    
    // MARK: - Delegates
    weak var delegate: CustomCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func countUpButtonTapped(_ sender: UIButton) {
        count += 1
        self.counterLabel.text = "\(self.count)"
        delegate?.stepperButtonValueChanged(self)
    }
    
    @IBAction func countDownButtonTapped(_ sender: UIButton) {
        guard count > 0 else { return }
        count -= 1
        counterLabel.text = "\(count)"
        delegate?.stepperButtonValueChanged(self)
    }
}

// MARK: - Setup Methods
extension TestTableViewCell {
    private func configureCell() {
        guard let item = item else { return }
        priceLabel.text = "\(item.price)"
    }
}
