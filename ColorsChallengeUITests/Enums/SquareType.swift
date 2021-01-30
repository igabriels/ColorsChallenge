//
//  SquareType.swift
//  ColorsChallengeUITests
//
//  Created by Herzon Rodriguez on 29/01/21.
//

import Foundation

enum SquareType: String, CaseIterable {
    case numeric = "#000000"
    case red = "#FF0000"
    case green = "#00FF00"
    case blue = "#0000FF"
    
    static func indexOfItem(_ string: String) -> Int {
        switch string {
            case "Red": return 1
            case "Green": return 2
            case "Blue": return 3
            default: return 0
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
