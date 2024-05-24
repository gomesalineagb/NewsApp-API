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
        sut?.network = nil
    }

    func test_when_call_fetchNews_with_success_should_return_data() {
        sut?.fetchAllNews()
                    
        XCTAssertEqual(self.presenterSpy?.calledMethods, [.fetchDataSuccess(data: .mockArray)])
    }
    
    func test_when_call_fetchNews_with_failure_should_return_error() {
        network = NewsRequest(urlSession: URLSessionErrorSpy())
        presenterSpy = NewsListInteractorOutputSpy()
        sut = .init(presenter: presenterSpy, network: network)
        
        sut?.fetchAllNews()
        XCTAssertEqual(self.presenterSpy?.calledMethods, [.fetchDataFailure(message: "Your API key is missing. Append this to the URL with the apiKey param, or use the x-api-key HTTP header.")])
    }
    
    func test_network_sucess_with_data() {
        network?.fetchAllNews(completion: { response, _ in
            
            XCTAssertEqual(response, .mock)
        })
    }
    
    func test_network_failure() {
        network = NewsRequest(urlSession: URLSessionErrorSpy())
        network?.fetchAllNews(completion: { response, _ in
            XCTAssertEqual(response, .error)
        })
    }
}

class URLSessionSuccessSpy: URLSession {
    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, (any Error)?) -> Void) -> URLSessionDataTask {
        guard
            let url = Bundle(for: URLSessionSuccessSpy.self).url(forResource: "newsResponseMockSuccess.json", withExtension: nil),
            let data = try? Data(contentsOf: url)
        else {
            XCTFail("Missing file: NewsResponseMockSuccess.json")
            return URLSessionDataTaskSpy()
        }
        
        completionHandler(data, URLResponse(), nil)
        return URLSessionDataTaskSpy()
    }
}

class URLSessionErrorSpy: URLSession {
    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, (any Error)?) -> Void) -> URLSessionDataTask {
        guard 
            let data = Bundle(for: URLSessionErrorSpy.self).url(forResource: "newsResponseMockError.json", withExtension: nil),
                let json = try? Data(contentsOf: data)
        else {
            XCTFail("Missing file: NewsResponseMockError.json")
            return URLSessionDataTaskSpy()
        }
        
        completionHandler(json, URLResponse(), nil)
        return URLSessionDataTaskSpy()
    }
}

class URLSessionDataTaskSpy: URLSessionDataTask {
    override func resume() {}
}
