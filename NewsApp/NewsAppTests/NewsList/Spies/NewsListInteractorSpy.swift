//
//  NewsListInteractorInputProtocolSpy.swift
//  NewsAppTests
//
//  Created by João Paulo Pereira dos Santos on 23/05/24.
//

@testable import NewsApp
import UIKit

class NewsListInteractorInputProtocolSpy: NewsListInteractorInputProtocol {
    var presenter: (any NewsListInteractorOutputProtocol)?
    var network: (any NewsListRequestProtocol)?
    
    enum Methods: Equatable {
        case fetchAllNews
        case search(text: String)
        case downloadImage(url: String?, index: Int)
    }
    
    private(set) var calledMethods: [Methods] = []
    
    func fetchAllNews() {
        calledMethods.append(.fetchAllNews)
    }
    
    func search(with text: String) {
        calledMethods.append(.search(text: text))
    }
    
    func downloadImage(for url: String?, index: Int) {
        calledMethods.append(.downloadImage(url: url, index: index))
    }
}

class NewsListInteractorOutputSpy: NewsListInteractorOutputProtocol {
    
    enum Methods: Equatable {
        case fetchDataSuccess(data: [NewsArticleDTO])
        case fetchDataFailure(message: String?)
        case updateImage(index: Int, image: UIImage?)
    }
    
    var calledMethods: [Methods] = []
    
    func fetchDataSuccess(data: [NewsArticleDTO]) {
        calledMethods.append(.fetchDataSuccess(data: data))
    }
    
    func fetchDataFailure(with message: String?) {
        calledMethods.append(.fetchDataFailure(message: message))
    }
    
    func updateImage(for index: Int, image: UIImage?) {
        calledMethods.append(.updateImage(index: index, image: image))
    }
}
