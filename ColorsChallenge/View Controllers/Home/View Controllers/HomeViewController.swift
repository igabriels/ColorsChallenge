//
//  HomeViewController.swift
//  ColorsChallenge
//
//  Created by Herzon Rodriguez on 25/01/21.
//

import UIKit

enum SquareType: String, CaseIterable {
    case numeric = "Numeric"
    case red = "#FF0000"
    case green = "#00FF00"
    case blue = "#0000FF"
    
    var index: Int {
        switch self {
            case .numeric: return 0
            case .red: return 1
            case .green: return 2
            case .blue: return 3
        }
    }
    
    var name: String {
        switch self {
            case .numeric: return "Numbers"
            case .red: return "Red"
            case .green: return "Green"
            case .blue: return "Blue"
        }
    }
}

struct ColorSquare: Codable {
    let hexColor: String
    let value: Double
    let width: Double
    let height: Double
    
    var color: UIColor {
        return UIColor(hex: hexColor)
    }
    
    var type: SquareType {
        return SquareType(rawValue: hexColor) ?? .numeric
    }
    
    enum CodingKeys: String, CodingKey {
        case hexColor = "color"
        case value = "value"
        case width = "width"
        case height = "height"
    }
    
    static func createSquare(type: SquareType, value: Double = 0.0) -> ColorSquare {
        return ColorSquare(hexColor: type.rawValue, value: value, width: 0.0, height: 0.0)
    }
}

struct ResultSquare {
    let name: String
    var hexColor: String = ""
    var quantity: Double = 0.0
}

class HomeViewController: UIViewController {
    
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
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("ShouldReloadColorsList"), object: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        _initialConfigurations()
        requestColorsList()
    }
}

// MARK: - Configurations

extension HomeViewController {
    private func _initialConfigurations() {
        if selectionsArray.count == 0 {
            NotificationCenter.default.addObserver(self, selector: #selector(shouldReloadColorsList), name: NSNotification.Name("ShouldReloadColorsList"), object: nil)
        }
    }
}

// MARK: - Helpers

extension HomeViewController {
    static func restartGame() {
        NotificationCenter.default.post(name: NSNotification.Name("ShouldReloadColorsList"), object: nil)
    }
    
    @objc private func shouldReloadColorsList() {
        viewModels.removeAll()
        tableView.reloadData()
        requestColorsList()
    }
    
    private func requestColorsList() {
        RequestsManager.request(HomeRequests.getColorsList) { [unowned self] (data) in
            self.isLoadingMore = false
            guard let sectionsArray = try? JSONDecoder().decode([[ColorSquare]].self, from: data) else {
                return
            }
            
            for array in sectionsArray {
                viewModels.append(CollectionViewViewModel(items: array))
            }
            self.tableView.reloadData()
        } failure: { (error) in
            self.isLoadingMore = true
            print(error)
        }
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == viewModels.count-1 {
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
        return indexPath.row == viewModels.count-1 ? 44.0 : ColorsTableViewCell.height
    }
}

// MARK: - CollectionViewViewModelDelegate

extension HomeViewController: CollectionViewViewModelDelegate {
    func collectionViewViewModel(_ viewModel: CollectionViewViewModel, didSelectColorSquare colorSquare: ColorSquare) {
        var newSelection = selectionsArray
        newSelection.append(colorSquare)
        if newSelection.count == 5 {
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
