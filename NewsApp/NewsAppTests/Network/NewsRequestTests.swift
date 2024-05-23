//
//  NewsRequestTests.swift
//  NewsAppTests
//
//  Created by João Paulo Pereira dos Santos on 23/05/24.
//

import XCTest
@testable import NewsApp

final class NewsRequestTests: XCTestCase {
    
    private var interactor: NewsListInteractorInputProtocolSpy?
    private var sut: NewsRequest?
    
    override func setUp() {
        super.setUp()
        interactor = NewsListInteractorInputProtocolSpy()
        sut = NewsRequest(urlSession: URLSessionSuccessSpy.shared)
        interactor?.network = sut
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        interactor = nil
        sut = nil
        interactor?.network = nil
    }

    func test_fetchAllNews_should_return_data_succeed() {
        interactor?.search(with: "Test")
        
        XCTAssertEqual(interactor?.calledMethods, [.fetchAllNews])
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

class URLSessionSuccessSpy: URLSession {
    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, (any Error)?) -> Void) -> URLSessionDataTask {
        guard let data = Bundle(for: type(of: self)).url(forResource: "NewsResponseMockSuccess", withExtension: "json"),
                let json = try? Data(contentsOf: data) else {
            XCTFail("Missing file: NewsResponseMockSuccess.json")
            return URLSessionDataTask()
        }
        
        completionHandler(json, nil, nil)
        return URLSessionDataTask()
    }
}

class URLSessionErrorSpy: URLSession {
    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, (any Error)?) -> Void) -> URLSessionDataTask {
        guard let data = Bundle(for: type(of: self)).url(forResource: "NewsResponseMockError", withExtension: "json"),
                let json = try? Data(contentsOf: data) else {
            XCTFail("Missing file: NewsResponseMockError.json")
            return URLSessionDataTask()
        }
        
        completionHandler(json, nil, nil)
        return URLSessionDataTask()
    }
}
