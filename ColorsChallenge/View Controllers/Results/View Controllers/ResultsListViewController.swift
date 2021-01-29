//
//  ResultsListViewController.swift
//  ColorsChallenge
//
//  Created by Herzon Rodriguez on 28/01/21.
//

import UIKit
import CoreData

class ResultsListViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    private lazy var fetchedResultsController: NSFetchedResultsController<GameResult> = {
        let fetchRequest: NSFetchRequest<GameResult> = GameResult.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "timeStamp", ascending: false)]
        
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        frc.delegate = self
        try? frc.performFetch()
        return frc
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        _initialConfigurations()
    }
}

// MARK: - Configurations

extension ResultsListViewController {
    private func _initialConfigurations() {
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension ResultsListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.fetchedObjects?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ResultsListTableViewCell.typeName, for: indexPath) as! ResultsListTableViewCell
        
        let result = fetchedResultsController.object(at: indexPath)
        cell.configure(with: result)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ResultsListTableViewCell.height
    }
}

// MARK: - NSFetchedResultsControllerDelegate

extension ResultsListViewController: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch (type) {
        case .insert:
            tableView.insertSections(IndexSet.init(integer: sectionIndex), with: .fade)
        case .delete:
            tableView.deleteSections(IndexSet.init(integer: sectionIndex), with: .left)
        default: break
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch (type) {
        case .insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            break
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .left)
            }
            break
        case .update:
            if let indexPath = indexPath {
                tableView.reloadRows(at: [indexPath], with: .fade)
            }
        default: break
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
}

