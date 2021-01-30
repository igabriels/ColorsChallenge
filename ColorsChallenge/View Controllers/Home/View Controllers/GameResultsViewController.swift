//
//  GameResultsViewController.swift
//  ColorsChallenge
//
//  Created by Herzon Rodriguez on 27/01/21.
//

import UIKit

class GameResultsViewController: UIViewController {
    
    @IBOutlet private weak var squareView: UIView!
    @IBOutlet private weak var winnerLabel: UILabel!
    @IBOutlet private weak var resultsLabel: UILabel!
    
    private var resultsArray: [ResultSquare] = []

    class func instantiate(resultsArray: [ResultSquare]) -> GameResultsViewController {
        guard let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: GameResultsViewController.typeName) as? GameResultsViewController else {
            fatalError("Could not instantiate GameResultsViewController")
        }
        
        viewController.resultsArray = resultsArray
        
        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        _initialConfigurations()
    }
}

// MARK: - Configurations

extension GameResultsViewController {
    private func _initialConfigurations() {
        guard let winner = resultsArray.first else {
            fatalError("No winners array? Not possible!")
        }
        
        navigationItem.title = "Game finished!"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped(_:)))
        
        let winnerText = "\(winner.name) Wins!"
        squareView.isHidden = winner.name == ColorSquare.NumberTypeString
        squareView.backgroundColor = UIColor(hex: winner.hexColor)
        squareView.accessibilityLabel = winnerText
        squareView.accessibilityValue = winner.name
        winnerLabel.text = winnerText
        winnerLabel.accessibilityLabel = winnerText
        winnerLabel.accessibilityValue = winnerText
        
        for (index, item) in resultsArray.enumerated() {
            resultsLabel.text = "\(resultsLabel.text ?? "")\n\(index+1). \(item.name): \(String(format: "%.2f", item.value))"
        }
        
        CoreDataAccessors().saveWinner(winner)
    }
}

// MARK: - Actions

extension GameResultsViewController {
    @objc private func doneButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true) {
            HomeViewController.restartGame()
        }
    }
}
