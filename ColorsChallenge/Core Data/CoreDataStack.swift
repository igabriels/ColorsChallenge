//
//  CoreDataStack.swift
//  Vieweet
//
//  Created by Herzon Rodriguez on 28/01/21.
//

import Foundation
import CoreData

class CoreDataStack: NSObject {

    static let shared = CoreDataStack()
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ColorsChallenge")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Public Properties
    
    static var managedObjectContext: NSManagedObjectContext {
        return CoreDataStack.shared.persistentContainer.viewContext
    }
    
    // MARK: Initialization
    
    private override init() { }
    
    // MARK: - CoreDataStack Saving
    
    static func saveStack(_ context: NSManagedObjectContext = CoreDataStack.managedObjectContext) {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                print("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
