//
//  BusinessLogicManagerTests.swift
//  ColorsChallengeTests
//
//  Created by Herzon Rodriguez on 27/01/21.
//

import XCTest
@testable import ColorsChallenge

class BusinessLogicManagerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_determineWinnerPlaces3_RedWinner() {
        let items: [ColorSquare] = Array(repeating: ColorSquare.createSquare(type: .red), count: 5)
        let results = BusinessLogicManager.shared.determineWinnerPlaces3(fromItems: items)
        
        validateResultItem(results[0], name: ColorSquare.RedTypeString, value: 5.0)
        validateResultItem(results[1], name: ColorSquare.NumberTypeString, value: 0.0)
        validateResultItem(results[2], name: ColorSquare.GreenTypeString, value: 0.0)
        validateResultItem(results[3], name: ColorSquare.BlueTypeString, value: 0.0)
    }
    
    func test_determineWinnerPlaces3_GreenWinner() {
        let items: [ColorSquare] = Array(repeating: ColorSquare.createSquare(type: .green), count: 5)
        let results = BusinessLogicManager.shared.determineWinnerPlaces3(fromItems: items)
        
        validateResultItem(results[0], name: ColorSquare.GreenTypeString, value: 5.0)
        validateResultItem(results[1], name: ColorSquare.NumberTypeString, value: 0.0)
        validateResultItem(results[2], name: ColorSquare.RedTypeString, value: 0.0)
        validateResultItem(results[3], name: ColorSquare.BlueTypeString, value: 0.0)
    }
    
    func test_determineWinnerPlaces3_BlueWinner() {
        let items: [ColorSquare] = Array(repeating: ColorSquare.createSquare(type: .blue), count: 5)
        let results = BusinessLogicManager.shared.determineWinnerPlaces3(fromItems: items)
        
        validateResultItem(results[0], name: ColorSquare.BlueTypeString, value: 5.0)
        validateResultItem(results[1], name: ColorSquare.NumberTypeString, value: 0.0)
        validateResultItem(results[2], name: ColorSquare.RedTypeString, value: 0.0)
        validateResultItem(results[3], name: ColorSquare.GreenTypeString, value: 0.0)
    }
    
    func test_determineWinnerPlaces3_NumbersWinner() {
        let items: [ColorSquare] = [ColorSquare.createSquare(type: .red, value: 1.0),
                                    ColorSquare.createSquare(type: .red, value: 1.0),
                                    ColorSquare.createSquare(type: .green, value: 1.0),
                                    ColorSquare.createSquare(type: .green, value: 1.0),
                                    ColorSquare.createSquare(type: .blue, value: 1.0)]
        let results = BusinessLogicManager.shared.determineWinnerPlaces3(fromItems: items)
        
        validateResultItem(results[0], name: ColorSquare.NumberTypeString, value: 5.0)
        validateResultItem(results[1], name: ColorSquare.RedTypeString, value: 2.0)
        validateResultItem(results[2], name: ColorSquare.GreenTypeString, value: 2.0)
        validateResultItem(results[3], name: ColorSquare.BlueTypeString, value: 1.0)
    }
    
    func test_determineWinnerPlaces3_AllTie() {
        let items: [ColorSquare] = [ColorSquare.createSquare(type: .red, value: 0.0),
                                    ColorSquare.createSquare(type: .red, value: 0.0),
                                    ColorSquare.createSquare(type: .green, value: 0.0),
                                    ColorSquare.createSquare(type: .green, value: 0.0),
                                    ColorSquare.createSquare(type: .blue, value: 1.0),
                                    ColorSquare.createSquare(type: .blue, value: 1.0)]
        let results = BusinessLogicManager.shared.determineWinnerPlaces3(fromItems: items)
        
        validateResultItem(results[0], name: ColorSquare.NumberTypeString, value: 2.0)
        validateResultItem(results[1], name: ColorSquare.RedTypeString, value: 2.0)
        validateResultItem(results[2], name: ColorSquare.GreenTypeString, value: 2.0)
        validateResultItem(results[3], name: ColorSquare.BlueTypeString, value: 2.0)
    }
    
    func test_determineWinnerPlaces3_NumbersRedTie() {
        let items: [ColorSquare] = Array(repeating: ColorSquare.createSquare(type: .red, value: 1.0), count: 5)
        let results = BusinessLogicManager.shared.determineWinnerPlaces3(fromItems: items)
        
        validateResultItem(results[0], name: ColorSquare.NumberTypeString, value: 5.0)
        validateResultItem(results[1], name: ColorSquare.RedTypeString, value: 5.0)
        validateResultItem(results[2], name: ColorSquare.GreenTypeString, value: 0.0)
        validateResultItem(results[3], name: ColorSquare.BlueTypeString, value: 0.0)
    }
    
    func test_determineWinnerPlaces3_NumbersGreenTie() {
        let items: [ColorSquare] = Array(repeating: ColorSquare.createSquare(type: .green, value: 1.0), count: 5)
        let results = BusinessLogicManager.shared.determineWinnerPlaces3(fromItems: items)
        
        validateResultItem(results[0], name: ColorSquare.NumberTypeString, value: 5.0)
        validateResultItem(results[1], name: ColorSquare.GreenTypeString, value: 5.0)
        validateResultItem(results[2], name: ColorSquare.RedTypeString, value: 0.0)
        validateResultItem(results[3], name: ColorSquare.BlueTypeString, value: 0.0)
    }
    
    func test_determineWinnerPlaces3_NumbersBlueTie() {
        let items: [ColorSquare] = Array(repeating: ColorSquare.createSquare(type: .blue, value: 1.0), count: 5)
        let results = BusinessLogicManager.shared.determineWinnerPlaces3(fromItems: items)
        
        validateResultItem(results[0], name: ColorSquare.NumberTypeString, value: 5.0)
        validateResultItem(results[1], name: ColorSquare.BlueTypeString, value: 5.0)
        validateResultItem(results[2], name: ColorSquare.RedTypeString, value: 0.0)
        validateResultItem(results[3], name: ColorSquare.GreenTypeString, value: 0.0)
    }
    
    func test_determineWinnerPlaces3_NumbersRedGreenTie() {
        let items: [ColorSquare] = [ColorSquare.createSquare(type: .red, value: 1.0),
                                    ColorSquare.createSquare(type: .red, value: 1.0),
                                    ColorSquare.createSquare(type: .green, value: 0.0),
                                    ColorSquare.createSquare(type: .green, value: 0.0),
                                    ColorSquare.createSquare(type: .blue, value: 0.0)]
        let results = BusinessLogicManager.shared.determineWinnerPlaces3(fromItems: items)
        
        validateResultItem(results[0], name: ColorSquare.NumberTypeString, value: 2.0)
        validateResultItem(results[1], name: ColorSquare.RedTypeString, value: 2.0)
        validateResultItem(results[2], name: ColorSquare.GreenTypeString, value: 2.0)
        validateResultItem(results[3], name: ColorSquare.BlueTypeString, value: 1.0)
    }
    
    func test_determineWinnerPlaces3_NumbersRedBlueTie() {
        let items: [ColorSquare] = [ColorSquare.createSquare(type: .red, value: 1.0),
                                    ColorSquare.createSquare(type: .red, value: 1.0),
                                    ColorSquare.createSquare(type: .green, value: 0.0),
                                    ColorSquare.createSquare(type: .blue, value: 0.0),
                                    ColorSquare.createSquare(type: .blue, value: 0.0)]
        let results = BusinessLogicManager.shared.determineWinnerPlaces3(fromItems: items)
        
        validateResultItem(results[0], name: ColorSquare.NumberTypeString, value: 2.0)
        validateResultItem(results[1], name: ColorSquare.RedTypeString, value: 2.0)
        validateResultItem(results[2], name: ColorSquare.BlueTypeString, value: 2.0)
        validateResultItem(results[3], name: ColorSquare.GreenTypeString, value: 1.0)
    }
    
    func test_determineWinnerPlaces3_NumbersGreenBlueTie() {
        let items: [ColorSquare] = [ColorSquare.createSquare(type: .red, value: 1.0),
                                    ColorSquare.createSquare(type: .green, value: 1.0),
                                    ColorSquare.createSquare(type: .green, value: 0.0),
                                    ColorSquare.createSquare(type: .blue, value: 0.0),
                                    ColorSquare.createSquare(type: .blue, value: 0.0)]
        let results = BusinessLogicManager.shared.determineWinnerPlaces3(fromItems: items)
        
        validateResultItem(results[0], name: ColorSquare.NumberTypeString, value: 2.0)
        validateResultItem(results[1], name: ColorSquare.GreenTypeString, value: 2.0)
        validateResultItem(results[2], name: ColorSquare.BlueTypeString, value: 2.0)
        validateResultItem(results[3], name: ColorSquare.RedTypeString, value: 1.0)
    }
    
    func test_determineWinnerPlaces3_RedGreenTie() {
        let items: [ColorSquare] = [ColorSquare.createSquare(type: .red, value: 1.0),
                                    ColorSquare.createSquare(type: .red, value: 0.0),
                                    ColorSquare.createSquare(type: .green, value: 0.0),
                                    ColorSquare.createSquare(type: .green, value: 0.0),
                                    ColorSquare.createSquare(type: .blue, value: 0.0)]
        let results = BusinessLogicManager.shared.determineWinnerPlaces3(fromItems: items)
        
        validateResultItem(results[0], name: ColorSquare.RedTypeString, value: 2.0)
        validateResultItem(results[1], name: ColorSquare.GreenTypeString, value: 2.0)
        validateResultItem(results[2], name: ColorSquare.NumberTypeString, value: 1.0)
        validateResultItem(results[3], name: ColorSquare.BlueTypeString, value: 1.0)
    }
    
    func test_determineWinnerPlaces3_RedBlueTie() {
        let items: [ColorSquare] = [ColorSquare.createSquare(type: .red, value: 1.0),
                                    ColorSquare.createSquare(type: .red, value: 0.0),
                                    ColorSquare.createSquare(type: .green, value: 0.0),
                                    ColorSquare.createSquare(type: .blue, value: 0.0),
                                    ColorSquare.createSquare(type: .blue, value: 0.0)]
        let results = BusinessLogicManager.shared.determineWinnerPlaces3(fromItems: items)
        
        validateResultItem(results[0], name: ColorSquare.RedTypeString, value: 2.0)
        validateResultItem(results[1], name: ColorSquare.BlueTypeString, value: 2.0)
        validateResultItem(results[2], name: ColorSquare.NumberTypeString, value: 1.0)
        validateResultItem(results[3], name: ColorSquare.GreenTypeString, value: 1.0)
    }
    
    func test_determineWinnerPlaces3_RedGreenBlueTie() {
        let items: [ColorSquare] = [ColorSquare.createSquare(type: .red, value: 1.0),
                                    ColorSquare.createSquare(type: .red, value: 0.0),
                                    ColorSquare.createSquare(type: .green, value: 0.0),
                                    ColorSquare.createSquare(type: .green, value: 0.0),
                                    ColorSquare.createSquare(type: .blue, value: 0.0),
                                    ColorSquare.createSquare(type: .blue, value: 0.0)]
        let results = BusinessLogicManager.shared.determineWinnerPlaces3(fromItems: items)
        
        validateResultItem(results[0], name: ColorSquare.RedTypeString, value: 2.0)
        validateResultItem(results[1], name: ColorSquare.GreenTypeString, value: 2.0)
        validateResultItem(results[2], name: ColorSquare.BlueTypeString, value: 2.0)
        validateResultItem(results[3], name: ColorSquare.NumberTypeString, value: 1.0)
    }
    
    func test_determineWinnerPlaces3_GreenBlueTie() {
        let items: [ColorSquare] = [ColorSquare.createSquare(type: .red, value: 1.0),
                                    ColorSquare.createSquare(type: .green, value: 0.0),
                                    ColorSquare.createSquare(type: .green, value: 0.0),
                                    ColorSquare.createSquare(type: .blue, value: 0.0),
                                    ColorSquare.createSquare(type: .blue, value: 0.0)]
        let results = BusinessLogicManager.shared.determineWinnerPlaces3(fromItems: items)
        
        validateResultItem(results[0], name: ColorSquare.GreenTypeString, value: 2.0)
        validateResultItem(results[1], name: ColorSquare.BlueTypeString, value: 2.0)
        validateResultItem(results[2], name: ColorSquare.NumberTypeString, value: 1.0)
        validateResultItem(results[3], name: ColorSquare.RedTypeString, value: 1.0)
    }

    // MARK: - Helpers
    
    func validateResultItem(_ item: ResultSquare, name: String, value: Double) {
        XCTAssert(item.name == name && item.value == value)
    }
}
