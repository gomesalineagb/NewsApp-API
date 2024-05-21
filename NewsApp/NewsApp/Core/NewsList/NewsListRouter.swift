//
//  NewsListRouter.swift
//  NewsApp
//
//  Created by João Paulo Pereira dos Santos on 20/05/24.
//

import UIKit

public class NewsListRouter {
    
    private func setupModule() -> UIViewController {
        let network = NewsRequest()
        let interactor = NewsListInteractor()
        let presenter = NewsListPresenter()
        let viewController = NewsListViewController()
        
        network.interactor = interactor
        interactor.presenter = presenter
        interactor.network = network
        presenter.interactor = interactor
        presenter.view = viewController
        presenter.router = self
        viewController.presenter = presenter
        
        return viewController
    }
    
}

// MARK: - NewsListRouterProtocol
extension NewsListRouter: NewsListRouterProtocol {
    
    func showModule() -> UIViewController {
        setupModule()
    }
    
    func details(of article: NewsArticleDTO) {
        
    }
}
