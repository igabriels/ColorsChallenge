//
//  BusinessLogicManager.swift
//  ColorsChallenge
//
//  Created by Herzon Rodriguez on 27/01/21.
//

import UIKit

class BusinessLogicManager: NSObject {
    public static let shared = BusinessLogicManager()
    
    private override init() {
        
    }
    
    func determineWinnerPlaces1(fromItems itemsArray: [ColorSquare]) -> [ResultSquare] {
        var numericCount = ResultSquare(name: "Numbers")
        var redCount = ResultSquare(name: "Red", hexColor: "#FF0000")
        var greenCount = ResultSquare(name: "Green", hexColor: "#00FF00")
        var blueCount = ResultSquare(name: "Blue", hexColor: "#0000FF")
        
        for item in itemsArray {
            defer {
                numericCount.quantity += item.value
            }
            switch item.type {
                case .red: redCount.quantity += 1.0
                case .green: greenCount.quantity += 1.0
                case .blue: blueCount.quantity += 1.0
                default: print("Not a color")
            }
        }
        return [numericCount, redCount, greenCount, blueCount].sorted(by: { $0.quantity > $1.quantity })
    }
    
    func determineWinnerPlaces2(fromItems itemsArray: [ColorSquare]) -> [ResultSquare] {
        let numericCount = ResultSquare(name: "Numbers", quantity: itemsArray.map({ $0.value }).reduce(0, +))
        let redCount = ResultSquare(name: "Red", hexColor: "#FF0000", quantity: Double(itemsArray.filter({ $0.type == .red }).count))
        let greenCount = ResultSquare(name: "Green", hexColor: "#00FF00", quantity: Double(itemsArray.filter({ $0.type == .green }).count))
        let blueCount = ResultSquare(name: "Blue", hexColor: "#0000FF", quantity: Double(itemsArray.filter({ $0.type == .blue }).count))
        return [numericCount, redCount, greenCount, blueCount].sorted(by: { $0.quantity > $1.quantity })
    }
    
    func determineWinnerPlaces3(fromItems itemsArray: [ColorSquare]) -> [ResultSquare] {
        var colorsCount: [ResultSquare] = []
        for squareType in SquareType.allCases {
            colorsCount.append(ResultSquare(name: squareType.name, hexColor: squareType.rawValue))
        }
        
        for item in itemsArray {
            colorsCount[item.type.index].quantity += 1.0
            colorsCount[0].quantity += item.value
        }
        
        return colorsCount.sorted(by: { $0.quantity > $1.quantity })
    }
}
