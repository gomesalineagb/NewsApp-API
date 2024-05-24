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
    private weak var view: NewsListPresenterOutputSpy?
//    private var router: NewsListRouterPro?
    private var sut: NewsListPresenter?
   
    override func setUp() {
        interactor = NewsListInteractorInputProtocolSpy()
        view = NewsListPresenterOutputSpy()
        sut = NewsListPresenter(interactor: interactor, view: view, router: <#T##(any NewsListRouterProtocol)?#>)
    }
}
