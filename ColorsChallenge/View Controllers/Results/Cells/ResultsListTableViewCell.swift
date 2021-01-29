//
//  ResultsListTableViewCell.swift
//  ColorsChallenge
//
//  Created by Herzon Rodriguez on 28/01/21.
//

import UIKit

class ResultsListTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var colorView: UIView!
    @IBOutlet private weak var winnerLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

// MARK: - Configurable

extension ResultsListTableViewCell: Configurable {
    static var height: CGFloat { 60.0 }
    
    func configure(with object: Any?) {
        if let result = object as? GameResult, let winnerText = result.winner {
            colorView.backgroundColor = UIColor(hex: ColorSquare.hexCode(forType: winnerText))
            colorView.isHidden = winnerText == ColorSquare.NumberTypeString
            winnerLabel.text = "\(winnerText) Won!"
        }
    }
}
