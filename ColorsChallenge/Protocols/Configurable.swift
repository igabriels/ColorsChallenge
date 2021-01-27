//
//  Configurable.swift
//  ColorsChallenge
//
//  Created by Herzon Rodriguez on 1/25/21.
//

import UIKit

protocol Configurable {
    static var height: CGFloat { get }
    static var size: CGSize { get }
    func configure(with object: Any?)
}

extension Configurable {
    static var height: CGFloat { 0.0 }
    static var size: CGSize { .zero }
    func configure(with object: Any?) { }
}
