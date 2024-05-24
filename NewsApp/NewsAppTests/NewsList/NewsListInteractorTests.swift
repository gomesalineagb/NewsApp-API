//
//  NewsListInteractorTests.swift
//  NewsAppTests
//
//  Created by João Paulo Pereira dos Santos on 23/05/24.
//
@testable import NewsApp
import XCTest

final class NewsListInteractorTests: XCTestCase {

    private var sut: NewsListInteractor?
    private var network: NewsListRequestProtocol?
    private var presenterSpy: NewsListInteractorOutputSpy?
    
    override func setUp() {
        super.setUp()
        network = NewsRequest(urlSession: URLSessionSuccessSpy())
        presenterSpy = NewsListInteractorOutputSpy()
        sut = .init(presenter: presenterSpy, network: network)
    }
    
    override func tearDown() {
        network = nil
        presenterSpy = nil
        sut = nil
    }
//    
//    func test_when_call_fetchNews_with_success_should_return_data() {
//        sut?.fetchAllNews()
//        
//        
//        network?.fetchAllNews(completion: { response, _ in
//            
//            XCTAssertEqual(response, .mock)
//            XCTAssertEqual(self.presenterSpy?.calledMethods, [.fetchDataSuccess(data: .mockArray)])
//        })
//
//    }
    
//    func test_when_call_fetchNews_with_failure_should_return_error() {
//        network = NewsRequest(urlSession: URLSessionErrorSpy())
//        presenterSpy = NewsListInteractorOutputSpy()
//        sut = .init(presenter: presenterSpy, network: network)
//        
//        sut?.fetchAllNews()
//        
//        XCTAssertEqual(presenterSpy?.calledMethods, [.fetchDataFailure(message: "Your API key is missing. Append this to the URL with the apiKey param, or use the x-api-key HTTP header.")])
//    }
}

class URLSessionSuccessSpy: URLSession {
    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, (any Error)?) -> Void) -> URLSessionDataTask {
        guard
            let url = Bundle(for: URLSessionSuccessSpy.self).url(forResource: "newsResponseMockSuccess.json", withExtension: nil),
            let data = try? Data(contentsOf: url)
        else {
            XCTFail("Missing file: NewsResponseMockSuccess.json")
            return URLSessionDataTask()
        }
        
        completionHandler(data, URLResponse(), nil)
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
