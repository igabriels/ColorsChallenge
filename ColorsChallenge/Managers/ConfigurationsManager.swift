//
//  ConfigurationsManager.swift
//  ColorsChallenge
//
//  Created by Herzon Rodriguez on 29/01/21.
//

import Foundation

struct ConfigurationsManager {
    public static let shared = ConfigurationsManager()
    
    private init() { }
    
    var isUITesting: Bool { ProcessInfo.processInfo.arguments.contains("UITesting") }
    var numberOfRoundsPerGame: Int {
        return Int(ProcessInfo.processInfo.environment["NumberOfRounds"] ?? "") ?? 5
    }
}
