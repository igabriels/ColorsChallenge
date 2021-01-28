//
//  ColorsTableViewCell.swift
//  ColorsChallenge
//
//  Created by Herzon Rodriguez on 25/01/21.
//

import UIKit

class ColorsTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var collectionView: UICollectionView!

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

extension ColorsTableViewCell: Configurable {
    static var height: CGFloat { 100.0 }
    
    func configure(with object: Any?) {
        if let viewModel = object as? CollectionViewViewModel {
            collectionView.dataSource = viewModel
            collectionView.delegate = viewModel
            collectionView.contentOffset = .zero
        }
    }
}
