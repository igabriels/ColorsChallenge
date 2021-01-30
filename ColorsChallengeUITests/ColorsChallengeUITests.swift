//
//  ColorsChallengeUITests.swift
//  ColorsChallengeUITests
//
//  Created by Herzon Rodriguez on 29/01/21.
//

import XCTest

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

struct ComparisonSquare {
    let name: String
    var value: Double = 0.0
}

class ColorsChallengeUITests: XCTestCase {
    
    let app = XCUIApplication()
    
    private let UITesting = "UITesting"
    private let NumberOfRounds = "NumberOfRounds"
    private let NumberOfRoundsPerGame = 3

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        
        app.launchArguments.append(UITesting)
        app.launchEnvironment[NumberOfRounds] = "\(NumberOfRoundsPerGame)"
        app.launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_completeGameAndCheckResultInList() throws {
        try XCTSkipIf(NumberOfRoundsPerGame == 0, "Skipped because we need at least 1 round to play")
        
        var counts: [ComparisonSquare] = []
        for item in SquareType.allCases {
            counts.append(ComparisonSquare(name: item.name, value: 0.0))
        }
        var currentWinner = ""
        
        for i in 1...NumberOfRoundsPerGame {
            let tableViewCell = app.tables.firstMatch.cells.firstMatch
            XCTAssert(tableViewCell.waitForExistence(timeout: 10.0), "TableView never loaded")
            let collectionViewCell = tableViewCell.collectionViews.firstMatch.cells.firstMatch
            XCTAssert(collectionViewCell.waitForExistence(timeout: 10.0), "CollectionView never loaded")
            
            let colorView = collectionViewCell.otherElements["ColorView"].firstMatch
            let valueLabel = collectionViewCell.staticTexts["ValueLabel"].firstMatch
            
            let colorValue = colorView.value as? String ?? ""
            let labelValue = Double(valueLabel.value as? String ?? "") ?? 0.0
            print("\(i). Color: \(colorValue) Value: \(labelValue)")
            
            let winningLabel = app.staticTexts["WinningLabel"].firstMatch
            if winningLabel.waitForExistence(timeout: 2.0), let winningValue = winningLabel.value as? String {
                XCTAssert(currentWinner == winningValue, "Not matching \(currentWinner) != \(winningValue)")
            }
            
            
            counts[SquareType.indexOfItem(colorValue)].value += 1.0
            counts[SquareType.indexOfItem("Numbers")].value += labelValue
            let currentOrder = counts.sorted(by: { $0.value > $1.value })
            currentWinner = currentOrder.first?.name ?? ""
            print("Results so far: \(currentOrder.map({ "\($0.name): \($0.value)" }))")
            
            collectionViewCell.tap()
            
            if i == NumberOfRoundsPerGame {
                counts = currentOrder
            }
        }
        
        guard let winner = counts.first else {
            XCTFail("No winners!?")
            return
        }
        
        let winnerColorView = app.otherElements["WinnerColorView"].firstMatch
        let winnerLabel = app.staticTexts["WinnerLabel"].firstMatch
        let winnerText = "\(winner.name) Wins!"
        let numbersDidntWin = winner.name != SquareType.numeric.name
        
        if numbersDidntWin {
            XCTAssert(winnerColorView.waitForExistence(timeout: 3.0), "Winner ColorView not presented even though a color did win")
            XCTAssert(winnerColorView.label == winnerText)
            XCTAssert(winnerColorView.value as? String == winner.name)
        }
        
        XCTAssert(winnerLabel.label == winnerText)
        XCTAssert(winnerLabel.value as? String == winnerText)
        
        app.buttons["Done"].firstMatch.tap()
        app.buttons["Results"].firstMatch.tap()
        
        let resultsCell = app.tables.firstMatch.cells.firstMatch
        
        let resultsWinnerLabel = resultsCell.staticTexts["ResultLabel"].firstMatch
        let resultsColorView = resultsCell.otherElements["ColorView"].firstMatch
        let winnerResultText = "\(winner.name) Won!"
        
        if numbersDidntWin {
            XCTAssert(resultsColorView.waitForExistence(timeout: 3.0), "Winner ColorView not presented even though a color did win")
            XCTAssert(resultsColorView.label == winnerResultText)
            XCTAssert(resultsColorView.value as? String == winner.name)
        }
        
        XCTAssert(resultsWinnerLabel.label == winnerResultText)
        XCTAssert(resultsWinnerLabel.value as? String == winnerResultText)
    }
}
