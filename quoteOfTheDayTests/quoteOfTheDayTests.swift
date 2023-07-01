//
//  quoteOfTheDayTests.swift
//  quoteOfTheDayTests
//
//  Created by Artem on 01/07/2023.
//

import XCTest
@testable import quoteOfTheDay

final class QuotesViewModelTests: XCTestCase {
    func testLoadQuotes() async throws {
           // Create a mock data source
           let mockDataSource = MockDataSource()
           
           // Create an instance of the view model with the mock data source
           let viewModel = QuotesViewModel(dataHandler: mockDataSource)
           
           // Perform the loadQuotes() function
            viewModel.loadQuotes()
           
           // Assert that quotesList is populated with the expected quotes after sleeping enough
        try await Task.sleep(nanoseconds: 3 * 1_000_000_000)
        
            XCTAssertEqual(viewModel.quotesList.count, 3)
            XCTAssertEqual(viewModel.quotesList[0].quote, "First")
            XCTAssertEqual(viewModel.quotesList[0].author, "Artem")
            XCTAssertEqual(viewModel.quotesList[1].quote, "Second")
            XCTAssertEqual(viewModel.quotesList[1].author, "Lena")
            XCTAssertEqual(viewModel.quotesList[2].quote, "Third")
            XCTAssertEqual(viewModel.quotesList[2].author, "Alice")
       }
       
       func testLoadQuote() async throws {
           // Create a mock data source
           let mockDataSource = MockDataSource()
           
           // Create an instance of the view model with the mock data source
           let viewModel = QuotesViewModel(dataHandler: mockDataSource)
           
           // Perform the loadQuote(withID:) function
            viewModel.loadQuote(withID: "1")
           
           // Assert that quote is populated with the expected quote
           try await Task.sleep(nanoseconds: 3 * 1_000_000_000)
           
           XCTAssertNotNil(viewModel.quote)
           XCTAssertEqual(viewModel.quote?.quote, "testQuote")
           XCTAssertEqual(viewModel.quote?.author, "testAuthor")
       }
}
