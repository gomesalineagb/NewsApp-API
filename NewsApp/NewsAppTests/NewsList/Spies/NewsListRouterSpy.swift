//
//  NewsListRouterSpy.swift
//  NewsAppTests
//
//  Created by João Paulo Pereira dos Santos on 24/05/24.
//

@testable import NewsApp
import UIKit

class NewsListRouterSpy: NewsListRouterProtocol {
    
    enum Methods: Equatable {
        case showModule
        case details
    }
    
    private(set) var calledMethods: [Methods] = []
    
    func showModule() -> UIViewController {
        calledMethods.append(.showModule)
        return UIViewController()
    }
    
    func details(of article: NewsApp.NewsArticleDTO) {
        calledMethods.append(.details)
    }
}
