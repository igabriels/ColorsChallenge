//
//  CollectionViewViewModel.swift
//  ColorsChallenge
//
//  Created by Herzon Rodriguez on 25/01/21.
//

import UIKit

protocol CollectionViewViewModelDelegate: class {
    func collectionViewViewModel(_ viewModel: CollectionViewViewModel, didSelectColorSquare colorSquare: ColorSquare)
}

class CollectionViewViewModel: NSObject {
    
    weak var delegate: CollectionViewViewModelDelegate? = nil
    private let dataSource: [ColorSquare]
    
    init(items: [ColorSquare], delegate: CollectionViewViewModelDelegate? = nil) {
        self.dataSource = items
        self.delegate = delegate
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout

extension CollectionViewViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ColorSquareCollectionViewCell.typeName, for: indexPath) as! ColorSquareCollectionViewCell
        
        cell.configure(with: dataSource[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let item = dataSource[indexPath.row]
        return CGSize(width: ColorSquareCollectionViewCell.size.width - (ColorSquareCollectionViewCell.size.width * CGFloat(item.width)),
                      height: ColorSquareCollectionViewCell.size.height - (ColorSquareCollectionViewCell.size.height * CGFloat(item.height)))
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.collectionViewViewModel(self, didSelectColorSquare: dataSource[indexPath.row]) 
    }
}
