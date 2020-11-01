//
//  GameViewControllerTests.swift
//  TandemCodeChallengeTests
//
//  Created by Boris Goncharov on 10/31/20.
//

import XCTest

@testable import TandemCodeChallenge

class GameViewControllerTests: XCTestCase {
    
    var controller: GameViewController!
    var fetcher: JsonDataFetcher!
    
    var questionsArray_mock: [Question]?
    var currentQuestion_mock: Question?

    override func setUpWithError() throws {
        super.setUp()
        controller = GameViewController()
        fetcher = JsonDataFetcher()
        
        fetcher.fetchQuestions { (result) in
            switch result {
            
            case .success(let data):
                self.questionsArray_mock = data
                self.questionsArray_mock?.shuffle()
                self.currentQuestion_mock = self.questionsArray_mock?.first
            case .failure(let error):
                print(error)
            }
            
            self.controller.viewDidLoad()
        }
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testScoreIsZeroWhenStarts() {
        XCTAssertEqual(controller.score, 0)
    }
    
    func  testAttemptsIsTwoWhenStarts() {
        XCTAssertEqual(controller.attemptsCount, 2)
    }
    
    func testQuestionsArrayRandom() {
        XCTAssertNotEqual(controller.questionsArray?[0], self.questionsArray_mock?[0])
    }
    
    func testCurrentQuestionIsTheFirstFromArray() {
        XCTAssertEqual(controller.questionsArray?[0], controller.currentQuestion)
    }
    
    func testButtonsTextNotNil() {
        XCTAssertNotNil(controller.answer0Button.titleLabel)
        XCTAssertNotNil(controller.answer1Button.titleLabel)
        XCTAssertNotNil(controller.answer2Button.titleLabel)
        XCTAssertNotNil(controller.answer3Button.titleLabel)
    }
    
    func testThreeButtonsAppear() {
        if controller.questionsArray?.count == 3 {
            XCTAssertTrue(controller.answer3Button.isHidden)
        }
    }
    
    func testFourButtonsAppear() {
        if controller.questionsArray?.count == 4 {
            XCTAssertFalse(controller.answer3Button.isHidden)
        }
    }
    
    func testAttemptOneImageAppear() {
        XCTAssertFalse(controller.attemptImageViewOne.isHidden)
    }
    
    func testAttemptTwoImageAppear() {
        XCTAssertFalse(controller.attemptImageViewTwo.isHidden)
    }
}
