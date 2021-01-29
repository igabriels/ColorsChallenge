//
//  SquareType.swift
//  ColorsChallenge
//
//  Created by Herzon Rodriguez on 28/01/21.
//

import Foundation

enum SquareType: String, CaseIterable {
    case numeric = "Numbers"
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
            case .numeric: return ColorSquare.NumberTypeString
            case .red: return ColorSquare.RedTypeString
            case .green: return ColorSquare.GreenTypeString
            case .blue: return ColorSquare.BlueTypeString
        }
    }
}
