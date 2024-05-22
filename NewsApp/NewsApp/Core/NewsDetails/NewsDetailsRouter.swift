//
//  NewsListRouter.swift
//  NewsApp
//
//  Created by João Paulo Pereira dos Santos on 21/05/24.
//

import UIKit

class NewsDetailsRouter {
    
    private func setupModule(article: NewsArticleDTO) -> UIViewController {
        let presenter = NewsDetailsPresenter(article: article)
        let viewController = NewsDetailsViewController()
        
        presenter.router = self
        presenter.view = viewController
        viewController.presenter = presenter
        
        return viewController
    }
}

extension NewsDetailsRouter: NewsDetailsRouterProtocol {
    func showModule(article: NewsArticleDTO) -> UIViewController {
        setupModule(article: article)
    }
}
