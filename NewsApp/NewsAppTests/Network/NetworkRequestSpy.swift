//
//  NetworkRequestSpy.swift
//  NewsAppTests
//
//  Created by João Paulo Pereira dos Santos on 23/05/24.
//

@testable import NewsApp
import UIKit

class NetworkRequestSpy: NewsListRequestProtocol {
    
    enum Methods: Equatable {
        case fetchAllNews
        case search
    }
    
    var calledMethods: [Methods] = []
    
    func fetchAllNews(completion: @escaping (NewsApp.NewsResponse?, (any Error)?) -> Void) {
        calledMethods.append(.fetchAllNews)
    }
    
    func search(with text: String, completion: @escaping (NewsApp.NewsResponse?, (any Error)?) -> Void) {
        calledMethods.append(.search)
    }
}
