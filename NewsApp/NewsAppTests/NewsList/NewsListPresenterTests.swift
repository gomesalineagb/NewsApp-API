//
//  NewsListPresenterTests.swift
//  NewsAppTests
//
//  Created by João Paulo Pereira dos Santos on 23/05/24.
//

@testable import NewsApp
import XCTest

final class NewsListPresenterTests: XCTestCase {
    private var interactor: NewsListInteractorInputProtocolSpy?
    private var view: NewsListPresenterOutputSpy?
    private var router: NewsListRouterSpy?
    private var sut: NewsListPresenter?
   
    override func setUp() {
        interactor = NewsListInteractorInputProtocolSpy()
        view = NewsListPresenterOutputSpy()
        router = NewsListRouterSpy()
        
        sut = NewsListPresenter(interactor: interactor, view: view, router: router)
    }
    
    func test_when_call_details_should_show_details() {
        sut?.fetchDataSuccess(data: .mockArray)
        sut?.didSelected(index: 0)
        
        XCTAssertEqual(router?.calledMethods, [.details])
    }
    
    func test_when_start_should_set_data() {
        sut?.viewDidLoad()
        
        XCTAssertEqual(view?.calledMethods, [.setLoading(isLoading: true)])
        XCTAssertEqual(interactor?.calledMethods, [.fetchAllNews])
    }
    
    func test_when_search_should_call_network() {
        sut?.search(with: "Test")
        
        XCTAssertEqual(view?.calledMethods, [.setLoading(isLoading: true)])
        XCTAssertEqual(interactor?.calledMethods, [.search(text: "Test")])
    }
    
    func test_when_donwload_image_should_call_network() {
        sut?.downloadImage(for: "", index: 0)
        
        XCTAssertEqual(interactor?.calledMethods, [.downloadImage(url: "", index: 0)])
    }
    
    func test_when_fetch_data_failure_should_show_error() {
        sut?.fetchDataFailure(with: "errror")
        
        XCTAssertEqual(view?.calledMethods, [.showError(message: "errror"), .setLoading(isLoading: false)])
    }
    
    func test_when_fetch_data_success_should_show_and_update_image() {
        sut?.fetchDataSuccess(data: .mockArray)
        
        XCTAssertEqual(view?.calledMethods, [.setDataSource(articles: .mockArray), .setLoading(isLoading: false)])
        XCTAssertEqual(interactor?.calledMethods, [.downloadImage(url: NewsResponse.mock.articles?[0].urlToImage, index: 0), .downloadImage(url: NewsResponse.mock.articles?[1].urlToImage, index: 1)])
    }
    
    func test_when_download_image_should_update() {
        sut?.fetchDataSuccess(data: .mockArray)
        sut?.updateImage(for: 0, image: nil)
        
        XCTAssertEqual(view?.calledMethods, [.setDataSource(articles: .mockArray), .setLoading(isLoading: false), .updateImage(index: 0, image: nil)])
    }
}
