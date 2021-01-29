//
//  ColorSquare.swift
//  ColorsChallenge
//
//  Created by Herzon Rodriguez on 28/01/21.
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
    
    var type: SquareType {
        return SquareType(rawValue: hexColor) ?? .numeric
    }
    
    enum CodingKeys: String, CodingKey {
        case hexColor = "color"
        case value = "value"
        case width = "width"
        case height = "height"
    }
    
    static let NumberTypeString = "Numbers"
    static let RedTypeString = "Red"
    static let GreenTypeString = "Green"
    static let BlueTypeString = "Blue"
    
    static func createSquare(type: SquareType, value: Double = 0.0) -> ColorSquare {
        return ColorSquare(hexColor: type.rawValue, value: value, width: 0.0, height: 0.0)
    }
}

extension ColorSquare {
    static func hexCode(forType type: String) -> String {
        switch type {
            case ColorSquare.RedTypeString: return SquareType.red.rawValue
            case ColorSquare.GreenTypeString: return SquareType.green.rawValue
            case ColorSquare.BlueTypeString: return SquareType.blue.rawValue
            default: return "#000000"
        }
    }
}
