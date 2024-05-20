//
//  NewsListPresenter.swift
//  NewsApp
//
//  Created by João Paulo Pereira dos Santos on 20/05/24.
//

import Foundation

public class NewsListPresenter {
    private var interactor: NewsListInteractorInputProtocol?
    private var view: NewsListPresenterOutputProtocol?
    private var router: NewsListRouterProtocol?
    
    init(interactor: NewsListInteractorInputProtocol? = nil, 
         view: NewsListPresenterOutputProtocol? = nil,
         router: NewsListRouterProtocol? = nil) {
        self.interactor = interactor
        self.view = view
        self.router = router
    }
}

// MARK: - NewsListPresenterInputProtocol
extension NewsListPresenter: NewsListPresenterInputProtocol {
    func viewDidLoad() {
        
    }
    
    func didSelected(article: NewsArticleDTO) {
        
    }
}

//MARK: - NewsListInteractorOutputProtocol
extension NewsListPresenter: NewsListInteractorOutputProtocol {
    func fetchDataSuccess(data: [NewsArticleDTO]) {
        
    }
    
    func fetchDataFailure() {
        
    }
}
