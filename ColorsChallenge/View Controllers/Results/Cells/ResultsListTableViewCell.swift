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
        
        isAccessibilityElement = false
        if let colorView = colorView, let winnerLabel = winnerLabel {
            accessibilityElements = [colorView, winnerLabel]
        }
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
        if let result = object as? GameResult, let winnerName = result.winner {
            let winnerText = "\(winnerName) Won!"
            let didNumbersWin = winnerName == ColorSquare.NumberTypeString
            colorView.backgroundColor = UIColor(hex: ColorSquare.hexCode(forType: winnerName))
            colorView.isHidden = didNumbersWin
            winnerLabel.text = winnerText
            
            colorView.accessibilityLabel = winnerText
            colorView.accessibilityValue = winnerName
            winnerLabel.accessibilityLabel = winnerText
            winnerLabel.accessibilityValue = winnerText
        }
    }
}
