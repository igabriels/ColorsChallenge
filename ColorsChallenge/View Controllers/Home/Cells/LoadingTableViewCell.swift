//
//  LoadingTableViewCell.swift
//  ColorsChallenge
//
//  Created by Herzon Rodriguez on 27/01/21.
//

import UIKit

class LoadingTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func animate() {
        activityIndicator.startAnimating()
    }
}
