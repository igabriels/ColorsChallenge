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
        
        validateResultItem(results[0], name: "Red", value: 5.0)
        validateResultItem(results[1], name: "Numbers", value: 0.0)
        validateResultItem(results[2], name: "Green", value: 0.0)
        validateResultItem(results[3], name: "Blue", value: 0.0)
    }
    
    func test_determineWinnerPlaces3_GreenWinner() {
        let items: [ColorSquare] = Array(repeating: ColorSquare.createSquare(type: .green), count: 5)
        let results = BusinessLogicManager.shared.determineWinnerPlaces3(fromItems: items)
        
        validateResultItem(results[0], name: "Green", value: 5.0)
        validateResultItem(results[1], name: "Numbers", value: 0.0)
        validateResultItem(results[2], name: "Red", value: 0.0)
        validateResultItem(results[3], name: "Blue", value: 0.0)
    }
    
    func test_determineWinnerPlaces3_BlueWinner() {
        let items: [ColorSquare] = Array(repeating: ColorSquare.createSquare(type: .blue), count: 5)
        let results = BusinessLogicManager.shared.determineWinnerPlaces3(fromItems: items)
        
        XCTAssert(results[0].name == "Blue" && results[0].quantity == 5.0)
        XCTAssert(results[1].name == "Numbers" && results[1].quantity == 0.0)
        XCTAssert(results[2].name == "Red" && results[2].quantity == 0.0)
        XCTAssert(results[3].name == "Green" && results[3].quantity == 0.0)
    }
    
    func test_determineWinnerPlaces3_NumbersWinner() {
        let items: [ColorSquare] = [ColorSquare.createSquare(type: .red, value: 1.0),
                                    ColorSquare.createSquare(type: .red, value: 1.0),
                                    ColorSquare.createSquare(type: .green, value: 1.0),
                                    ColorSquare.createSquare(type: .green, value: 1.0),
                                    ColorSquare.createSquare(type: .blue, value: 1.0)]
        let results = BusinessLogicManager.shared.determineWinnerPlaces3(fromItems: items)
        
        XCTAssert(results[0].name == "Numbers" && results[0].quantity == 5.0)
        XCTAssert(results[1].name == "Red" && results[1].quantity == 2.0)
        XCTAssert(results[2].name == "Green" && results[2].quantity == 2.0)
        XCTAssert(results[3].name == "Blue" && results[3].quantity == 1.0)
    }
    
    func test_determineWinnerPlaces3_AllTie() {
        let item1 = ColorSquare(hexColor: "#FF0000", value: 0.0, width: 0.0, height: 0.0)
        let item2 = ColorSquare(hexColor: "#FF0000", value: 0.0, width: 0.0, height: 0.0)
        let item3 = ColorSquare(hexColor: "#00FF00", value: 0.0, width: 0.0, height: 0.0)
        let item4 = ColorSquare(hexColor: "#00FF00", value: 0.0, width: 0.0, height: 0.0)
        let item5 = ColorSquare(hexColor: "#0000FF", value: 1.0, width: 0.0, height: 0.0)
        let item6 = ColorSquare(hexColor: "#0000FF", value: 1.0, width: 0.0, height: 0.0)
        
        let results = BusinessLogicManager.shared.determineWinnerPlaces3(fromItems: [item1, item2, item3, item4, item5, item6])
        
        XCTAssert(results[0].name == "Numbers")
        XCTAssert(results[1].name == "Red")
        XCTAssert(results[2].name == "Green")
        XCTAssert(results[3].name == "Blue")
        
        XCTAssert(results[0].quantity == 2.0)
        XCTAssert(results[1].quantity == 2.0)
        XCTAssert(results[2].quantity == 2.0)
        XCTAssert(results[3].quantity == 2.0)
    }
    
    func test_determineWinnerPlaces3_NumbersRedTie() {
        let item1 = ColorSquare(hexColor: "#FF0000", value: 1.0, width: 0.0, height: 0.0)
        let item2 = ColorSquare(hexColor: "#FF0000", value: 1.0, width: 0.0, height: 0.0)
        let item3 = ColorSquare(hexColor: "#FF0000", value: 1.0, width: 0.0, height: 0.0)
        let item4 = ColorSquare(hexColor: "#FF0000", value: 1.0, width: 0.0, height: 0.0)
        let item5 = ColorSquare(hexColor: "#FF0000", value: 1.0, width: 0.0, height: 0.0)
        
        let results = BusinessLogicManager.shared.determineWinnerPlaces3(fromItems: [item1, item2, item3, item4, item5])
        
        XCTAssert(results[0].name == "Numbers")
        XCTAssert(results[1].name == "Red")
        XCTAssert(results[2].name == "Green")
        XCTAssert(results[3].name == "Blue")
        
        XCTAssert(results[0].quantity == 5.0)
        XCTAssert(results[1].quantity == 5.0)
        XCTAssert(results[2].quantity == 0.0)
        XCTAssert(results[3].quantity == 0.0)
    }
    
    func test_determineWinnerPlaces3_NumbersGreenTie() {
        let item1 = ColorSquare(hexColor: "#00FF00", value: 1.0, width: 0.0, height: 0.0)
        let item2 = ColorSquare(hexColor: "#00FF00", value: 1.0, width: 0.0, height: 0.0)
        let item3 = ColorSquare(hexColor: "#00FF00", value: 1.0, width: 0.0, height: 0.0)
        let item4 = ColorSquare(hexColor: "#00FF00", value: 1.0, width: 0.0, height: 0.0)
        let item5 = ColorSquare(hexColor: "#00FF00", value: 1.0, width: 0.0, height: 0.0)
        
        let results = BusinessLogicManager.shared.determineWinnerPlaces3(fromItems: [item1, item2, item3, item4, item5])
        
        XCTAssert(results[0].name == "Numbers")
        XCTAssert(results[1].name == "Green")
        XCTAssert(results[2].name == "Red")
        XCTAssert(results[3].name == "Blue")
        
        XCTAssert(results[0].quantity == 5.0)
        XCTAssert(results[1].quantity == 5.0)
        XCTAssert(results[2].quantity == 0.0)
        XCTAssert(results[3].quantity == 0.0)
    }
    
    func test_determineWinnerPlaces3_NumbersBlueTie() {
        let item1 = ColorSquare(hexColor: "#0000FF", value: 1.0, width: 0.0, height: 0.0)
        let item2 = ColorSquare(hexColor: "#0000FF", value: 1.0, width: 0.0, height: 0.0)
        let item3 = ColorSquare(hexColor: "#0000FF", value: 1.0, width: 0.0, height: 0.0)
        let item4 = ColorSquare(hexColor: "#0000FF", value: 1.0, width: 0.0, height: 0.0)
        let item5 = ColorSquare(hexColor: "#0000FF", value: 1.0, width: 0.0, height: 0.0)
        
        let results = BusinessLogicManager.shared.determineWinnerPlaces3(fromItems: [item1, item2, item3, item4, item5])
        
        XCTAssert(results[0].name == "Numbers")
        XCTAssert(results[1].name == "Blue")
        XCTAssert(results[2].name == "Red")
        XCTAssert(results[3].name == "Green")
        
        XCTAssert(results[0].quantity == 5.0)
        XCTAssert(results[1].quantity == 5.0)
        XCTAssert(results[2].quantity == 0.0)
        XCTAssert(results[3].quantity == 0.0)
    }

    
    // MARK: - Helpers
    
    func validateResultItem(_ item: ResultSquare, name: String, value: Double) {
        XCTAssert(item.name == name && item.quantity == value)
    }
}
