//
//  CoreDataAccessors.swift
//  ColorsChallenge
//
//  Created by Herzon Rodriguez on 28/01/21.
//

import CoreData

class CoreDataAccessors {
    
    private var managedObjectContext: NSManagedObjectContext
    
    init(managedObjectContext: NSManagedObjectContext = CoreDataStack.managedObjectContext) {
        self.managedObjectContext = managedObjectContext
    }
    
    func saveWinner(_ result: ResultSquare) {
        let winnerObject = NSEntityDescription.insertNewObject(forEntityName: "GameResult", into: managedObjectContext) as! GameResult
        winnerObject.winner = result.name
        winnerObject.timeStamp = Date()
        CoreDataStack.saveStack()
    }
}
