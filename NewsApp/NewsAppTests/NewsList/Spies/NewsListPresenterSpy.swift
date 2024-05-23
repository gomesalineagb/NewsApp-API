//
//  NewsListPresenterSpy.swift
//  NewsAppTests
//
//  Created by João Paulo Pereira dos Santos on 23/05/24.
//

@testable import NewsApp
import UIKit

class NewsListPresenterInputSpy: NewsListPresenterInputProtocol {
    var interactor: (any NewsApp.NewsListInteractorInputProtocol)?
    var view: (any NewsApp.NewsListPresenterOutputProtocol)?
    var router: (any NewsApp.NewsListRouterProtocol)?
    
    enum Methods: Equatable {
        case viewDidLoad
        case didSelected(index: Int)
        case downloadImage(url: String?, index: Int)
        case search(text: String)
    }
    
    private(set) var calledMethods: [Methods] = []
    
    func viewDidLoad() {
        calledMethods.append(.viewDidLoad)
    }
    
    func didSelected(index: Int) {
        calledMethods.append(.didSelected(index: index))
    }
    
    func downloadImage(for url: String?, index: Int) {
        calledMethods.append(.downloadImage(url: url, index: index))
    }
    
    func search(with text: String) {
        calledMethods.append(.search(text: text))
    }
}

class NewsListPresenterOutputSpy: NewsListPresenterOutputProtocol {
    var presenter: (any NewsApp.NewsListPresenterInputProtocol)?
    
    enum Methods: Equatable {
        case setDataSource(articles: [NewsApp.NewsArticleDTO])
        case setLoading(isLoading: Bool)
        case showError(message: String?)
        case updateImage(index: Int, image: UIImage?)
    }
    
    private(set) var calledMethods: [Methods] = []
    
    func setDataSource(articles: [NewsApp.NewsArticleDTO]) {
        calledMethods.append(.setDataSource(articles: articles))
    }
    
    func setLoading(isLoading: Bool) {
        calledMethods.append(.setLoading(isLoading: isLoading))
    }
    
    func showError(with message: String?) {
        calledMethods.append(.showError(message: message))
    }
    
    func updateImage(for index: Int, image: UIImage?) {
        calledMethods.append(.updateImage(index: index, image: image))
    }
}
