//
//  ColorSquareCollectionViewCell.swift
//  ColorsChallenge
//
//  Created by Herzon Rodriguez on 25/01/21.
//

import UIKit

class ColorSquareCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var valueLabel: UILabel!
    @IBOutlet private weak var colorView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        isAccessibilityElement = false
    }
}

extension ColorSquareCollectionViewCell: Configurable {
    static var size: CGSize { CGSize(width: 100.0, height: 100.0) }
    
    func configure(with object: Any?) {
        if let item = object as? ColorSquare {
            let valueString = "\(item.value)"
            valueLabel.text = valueString
            valueLabel.accessibilityValue = valueString
            colorView.backgroundColor = item.color
            colorView.accessibilityValue = item.type.name
        }
    }
}
