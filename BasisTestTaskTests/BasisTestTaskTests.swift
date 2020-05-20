//
//  BasisTestTaskTests.swift
//  BasisTestTaskTests
//
//  Created by Himanshu Chaurasiya on 18/05/20.
//  Copyright © 2020 Himanshu Chaurasiya. All rights reserved.
//

import XCTest
@testable import BasisTestTask

class BasisTestTaskTests: XCTestCase {
    
    var viewModel: CardsViewModel!
    var view: CardViewMock!
    var apiService = ApiServiceMock()
    var response: ResponseModel!
    
    override func setUpWithError() throws {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: "response", withExtension: "json"),
            let data = try? Data(contentsOf: url) else {
                return
        }
        let decoder = JSONDecoder()
        guard let cardResponse = try? decoder.decode(ResponseModel.self, from: data) else {
            return
        }
        response = cardResponse
        view = CardViewMock()
        viewModel = CardsViewModel(view: view, apiService: apiService)
    }
    
    
    private func setupViewModelWithError() {
        viewModel.fetchCardsError(error: "Something went wrong. Please try again")
    }
    
    private func setupViewModelWithSuccess() {
        viewModel.fetchCardsSuccess(data: response)
    }
    
    func test_apiSuccess_shouldReloadView() {
        setupViewModelWithSuccess()
        XCTAssertTrue(view.reloadViewCalled)
    }
    
    func test_apiFailure_shouldShowErrorWithMessage() {
        setupViewModelWithError()
        XCTAssertEqual(view.showErrorCalledWithArguments, "Something went wrong. Please try again")
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_numberOfElement() throws {
        setupViewModelWithSuccess()
        XCTAssertEqual(viewModel.numberOfItems, 8)
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    
    class CardViewMock: CardsView {
        var showErrorCalledWithArguments: String?
        func showError(message: String) {
            showErrorCalledWithArguments = message
        }
        
        var reloadViewCalled = false
        func reloadView() {
            reloadViewCalled = true
        }
    }
    
    class ApiServiceMock: CardsInteractor {
        var fetchCardsCalled = false
        func fetchCards() {
            fetchCardsCalled = true
        }
        
        
    }
    
}
