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
}

extension ColorSquareCollectionViewCell: Configurable {
    static var size: CGSize { CGSize(width: 100.0, height: 100.0) }
    
    func configure(with object: Any?) {
        if let item = object as? ColorSquare {
            valueLabel.text = "\(item.value)"
            colorView.backgroundColor = item.color
        }
    }
}
