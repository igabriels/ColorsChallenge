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
        var numericCount = ResultSquare(name: ColorSquare.NumberTypeString)
        var redCount = ResultSquare(name: ColorSquare.RedTypeString, hexColor: "#FF0000")
        var greenCount = ResultSquare(name: ColorSquare.GreenTypeString, hexColor: "#00FF00")
        var blueCount = ResultSquare(name: ColorSquare.BlueTypeString, hexColor: "#0000FF")
        
        for item in itemsArray {
            defer {
                numericCount.value += item.value
            }
            switch item.type {
                case .red: redCount.value += 1.0
                case .green: greenCount.value += 1.0
                case .blue: blueCount.value += 1.0
                default: print("Not a color")
            }
        }
        return [numericCount, redCount, greenCount, blueCount].sorted(by: { $0.value > $1.value })
    }
    
    func determineWinnerPlaces2(fromItems itemsArray: [ColorSquare]) -> [ResultSquare] {
        let numericCount = ResultSquare(name: ColorSquare.NumberTypeString, value: itemsArray.map({ $0.value }).reduce(0, +))
        let redCount = ResultSquare(name: ColorSquare.RedTypeString, hexColor: "#FF0000", value: Double(itemsArray.filter({ $0.type == .red }).count))
        let greenCount = ResultSquare(name: ColorSquare.GreenTypeString, hexColor: "#00FF00", value: Double(itemsArray.filter({ $0.type == .green }).count))
        let blueCount = ResultSquare(name: ColorSquare.BlueTypeString, hexColor: "#0000FF", value: Double(itemsArray.filter({ $0.type == .blue }).count))
        return [numericCount, redCount, greenCount, blueCount].sorted(by: { $0.value > $1.value })
    }
    
    func determineWinnerPlaces3(fromItems itemsArray: [ColorSquare]) -> [ResultSquare] {
        if itemsArray.count == 0 {
            return []
        }
        
        var colorsCount: [ResultSquare] = []
        for squareType in SquareType.allCases {
            colorsCount.append(ResultSquare(name: squareType.name, hexColor: squareType.rawValue))
        }
        
        for item in itemsArray {
            colorsCount[item.type.index].value += 1.0
            colorsCount[0].value += item.value
        }
        
        return colorsCount.sorted(by: { $0.value > $1.value })
    }
}
