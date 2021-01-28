//
//  UIColor+FromHex.swift
//  ColorsChallenge
//
//  Created by Herzon Rodriguez on 26/01/21.
//

import UIKit

extension UIColor {
    public convenience init(hex: String) {
        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 1.0

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])
            
            if hexColor.count == 6 {
                var hexNumber: UInt32 = 0
                Scanner(string: hexColor).scanHexInt32(&hexNumber)
                r = CGFloat((hexNumber & 0xff0000) >> 16) / 255
                g = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
                b = CGFloat((hexNumber & 0x0000ff)) / 255
            } else if hexColor.count == 8 {
                var hexNumber: UInt64 = 0
                Scanner(string: hexColor).scanHexInt64(&hexNumber)
                r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                a = CGFloat(hexNumber & 0x000000ff) / 255
            }
        }

        self.init(red: r, green: g, blue: b, alpha: a)
    }
}
