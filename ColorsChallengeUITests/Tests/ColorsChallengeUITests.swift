//
//  ColorsChallengeUITests.swift
//  ColorsChallengeUITests
//
//  Created by Herzon Rodriguez on 29/01/21.
//

import XCTest

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
    
    // MARK: - Tests
    
    func test_completeGameAndCheckResultInList() throws {
        try XCTSkipIf(NumberOfRoundsPerGame == 0, "Skipped because we need at least 1 round to play")
        
        var counts: [ComparisonSquare] = []
        for item in SquareType.allCases {
            counts.append(ComparisonSquare(name: item.name, value: 0.0))
        }
        var currentWinner = ""
        
        for i in 1...NumberOfRoundsPerGame {
            
            // Get the first cell of the main tableView
            let tableViewCell = app.tables.firstMatch.cells.firstMatch
            // Wait for the cell to appear
            XCTAssert(tableViewCell.waitForExistence(timeout: 10.0), "TableView never loaded")
            
            // Get the first cell in the first cell collectionView
            let collectionViewCell = tableViewCell.collectionViews.firstMatch.cells.firstMatch
            // Wait for the cell to appear
            XCTAssert(collectionViewCell.waitForExistence(timeout: 10.0), "CollectionView never loaded")
            
            // Get the label and colored view
            let colorView = collectionViewCell.otherElements["ColorView"].firstMatch
            let valueLabel = collectionViewCell.staticTexts["ValueLabel"].firstMatch
            
            // Extract the values
            let colorValue = colorView.value as? String ?? ""
            let labelValue = Double(valueLabel.value as? String ?? "") ?? 0.0
            print("\(i). Color: \(colorValue) Value: \(labelValue)")
            
            // Check if the label for the current winner (top right corner) exists and compare it with the actual result
            // to see if they match and the logic is correct
            let winningLabel = app.staticTexts["WinningLabel"].firstMatch
            if winningLabel.waitForExistence(timeout: 2.0), let winningValue = winningLabel.value as? String {
                XCTAssert(currentWinner == winningValue, "Not matching \(currentWinner) != \(winningValue)")
            }
            
            // Add the count of colored squares and values
            counts[SquareType.indexOfItem(colorValue)].value += 1.0
            counts[SquareType.indexOfItem("Numbers")].value += labelValue
            let currentOrder = counts.sorted(by: { $0.value > $1.value })
            currentWinner = currentOrder.first?.name ?? ""
            print("Results so far: \(currentOrder.map({ "\($0.name): \($0.value)" }))")
            
            // Tap the collectionView cell to advance to the next screen
            collectionViewCell.tap()
            
            // Check if we are at the last screen of the game, if so we will present the results list
            if i == NumberOfRoundsPerGame {
                counts = currentOrder
            }
        }
        
        
        guard let winner = counts.first else {
            XCTFail("No winners!?")
            return
        }
        
        // Get the winner elements in the Game Result screen
        let winnerColorView = app.otherElements["WinnerColorView"].firstMatch
        let winnerLabel = app.staticTexts["WinnerLabel"].firstMatch
        let winnerText = "\(winner.name) Wins!"
        let numbersDidntWin = winner.name != SquareType.numeric.name
        
        // Compare if the numbers didn't win, the values on the colored view
        if numbersDidntWin {
            XCTAssert(winnerColorView.waitForExistence(timeout: 3.0), "Winner ColorView not presented even though a color did win")
            XCTAssert(winnerColorView.label == winnerText)
            XCTAssert(winnerColorView.value as? String == winner.name)
        }
        
        // Check winner label
        XCTAssert(winnerLabel.label == winnerText)
        XCTAssert(winnerLabel.value as? String == winnerText)
        
        // Dismiss the Game Results screen and navigate to the Results tab
        app.buttons["Done"].firstMatch.tap()
        let resultsTabBarButton = app.tabBars.buttons["Results"].firstMatch
        _ = resultsTabBarButton.waitForExistence(timeout: 3.0)
        resultsTabBarButton.tap()
        
        // Same logic for winners as before but for the first cell
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
