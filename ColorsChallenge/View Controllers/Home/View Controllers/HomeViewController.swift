//
//  HomeViewController.swift
//  ColorsChallenge
//
//  Created by Herzon Rodriguez on 25/01/21.
//

import UIKit

struct ColorSquare: Codable {
    let hexColor: String
    let value: Double
    let width: Double
    let height: Double
    
    var color: UIColor {
        return UIColor(hex: hexColor)
    }
    
    enum CodingKeys: String, CodingKey {
        case hexColor = "color"
        case value = "value"
        case width = "width"
        case height = "height"
    }
}

class HomeViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    private var dataSource: [[ColorSquare]] = []
    private var viewModels: [CollectionViewViewModel] = []//[CollectionViewViewModel(),CollectionViewViewModel(),CollectionViewViewModel(),CollectionViewViewModel(),CollectionViewViewModel(),]
    
    class func instantiate() -> HomeViewController {
        guard let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: HomeViewController.typeName) as? HomeViewController else {
            fatalError("Could not instantiate HomeViewController")
        }
        
        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        requestColorsList()
    }
}

// MARK: - Configurations

// MARK: - Helpers

extension HomeViewController {
    private func requestColorsList() {
        RequestsManager.request(HomeRequests.getColorsList) { [unowned self] (data) in
            guard let sectionsArray = try? JSONDecoder().decode([[ColorSquare]].self, from: data) else {
                return
            }
            
            for array in sectionsArray {
                viewModels.append(CollectionViewViewModel(items: array))
            }
            self.tableView.reloadData()
        } failure: { (error) in
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
        let cell = tableView.dequeueReusableCell(withIdentifier: ColorsTableViewCell.typeName, for: indexPath) as! ColorsTableViewCell
        
        cell.configure(with: viewModels[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ColorsTableViewCell.height
    }
}
