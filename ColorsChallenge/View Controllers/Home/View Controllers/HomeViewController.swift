//
//  HomeViewController.swift
//  ColorsChallenge
//
//  Created by Herzon Rodriguez on 25/01/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    private let NumberOfPicks = ConfigurationsManager.shared.numberOfRoundsPerGame
    
    @IBOutlet private weak var tableView: UITableView!
    
    private var selectionsArray: [ColorSquare] = []
    private var viewModels: [CollectionViewViewModel] = []
    
    private var isLoadingMore = false
    
    class func instantiate(previousSelections: [ColorSquare]) -> HomeViewController {
        guard let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: HomeViewController.typeName) as? HomeViewController else {
            fatalError("Could not instantiate HomeViewController")
        }
        
        viewController.selectionsArray = previousSelections
        viewController.navigationItem.title = "Home (\(previousSelections.count+1))"
        
        return viewController
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NotificationConstants.ShouldReloadColorsList, object: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        _initialConfigurations()
        requestColorsList(showLoadingIndicator: true)
    }
}

// MARK: - Configurations

extension HomeViewController {
    private func _initialConfigurations() {
        tableView.isAccessibilityElement = false
        
        if selectionsArray.count == 0 {
            NotificationCenter.default.addObserver(self, selector: #selector(shouldReloadColorsList), name: NotificationConstants.ShouldReloadColorsList, object: nil)
        }
        
        if let winning = BusinessLogicManager.shared.determineWinnerPlaces3(fromItems: selectionsArray).first {
            let label = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: 30.0, height: 30.0))
            let isNumbersWinning = winning.hexColor == SquareType.numeric.rawValue
            label.textAlignment = .center
            label.backgroundColor = isNumbersWinning ? .clear : UIColor(hex: winning.hexColor)
            label.text = isNumbersWinning ? "2" : ""
            label.accessibilityIdentifier = "WinningLabel"
            label.accessibilityLabel = "\(winning.name) is winning"
            label.accessibilityValue = winning.name
            navigationItem.rightBarButtonItem = UIBarButtonItem(customView: label)
        }
    }
}

// MARK: - Helpers

extension HomeViewController {
    static func restartGame() {
        NotificationCenter.default.post(name: NotificationConstants.ShouldReloadColorsList, object: nil)
    }
    
    @objc private func shouldReloadColorsList() {
        viewModels.removeAll()
        tableView.reloadData()
        requestColorsList(showLoadingIndicator: true)
    }
    
    private func requestColorsList(showLoadingIndicator: Bool = false) {
        if showLoadingIndicator {
            view.showLoadingView()
        }
        RequestsManager.request(HomeRequests.getColorsList) { [unowned self] (data) in
            self.view.removeLoadingView()
            self.isLoadingMore = false
            guard let sectionsArray = try? JSONDecoder().decode([[ColorSquare]].self, from: data) else {
                return
            }
            
            for array in sectionsArray {
                viewModels.append(CollectionViewViewModel(items: array))
            }
            self.tableView.reloadData()
        } failure: { (error) in
            self.view.removeLoadingView()
            self.isLoadingMore = true
            print(error)
        }
    }
    
    private func shouldShowLoaderCell(at indexPath: IndexPath) -> Bool {
        indexPath.row == viewModels.count-1 && !ConfigurationsManager.shared.isUITesting
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if shouldShowLoaderCell(at: indexPath) {
            if !isLoadingMore {
                isLoadingMore = true
                requestColorsList()
            }
            
            let cell = tableView.dequeueReusableCell(withIdentifier: LoadingTableViewCell.typeName, for: indexPath) as! LoadingTableViewCell
            cell.animate()
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ColorsTableViewCell.typeName, for: indexPath) as! ColorsTableViewCell
        
        let viewModel = viewModels[indexPath.row]
        cell.configure(with: viewModel)
        viewModel.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return shouldShowLoaderCell(at: indexPath) ? 44.0 : ColorsTableViewCell.height
    }
}

// MARK: - CollectionViewViewModelDelegate

extension HomeViewController: CollectionViewViewModelDelegate {
    func collectionViewViewModel(_ viewModel: CollectionViewViewModel, didSelectColorSquare colorSquare: ColorSquare) {
        var newSelection = selectionsArray
        newSelection.append(colorSquare)
        if newSelection.count == NumberOfPicks {
            let resultsArray = BusinessLogicManager.shared.determineWinnerPlaces3(fromItems: newSelection)
            
            let viewController = GameResultsViewController.instantiate(resultsArray: resultsArray)
            let navigationController = UINavigationController(rootViewController: viewController)
            present(navigationController, animated: true) {
                self.navigationController?.popToRootViewController(animated: false)
            }
        } else {
            let homeViewController = HomeViewController.instantiate(previousSelections: newSelection)
            navigationController?.pushViewController(homeViewController, animated: true)
        }
    }
}
