//
//  NewsListPresenter.swift
//  NewsApp
//
//  Created by João Paulo Pereira dos Santos on 20/05/24.
//

import Foundation

public class NewsListPresenter {
    internal var interactor: NewsListInteractorInputProtocol?
    weak internal var view: NewsListPresenterOutputProtocol?
    internal var router: NewsListRouterProtocol?
    
    private var articles: [NewsArticleDTO] = []
    
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
        view?.setLoading(isLoading: true)
        interactor?.fetchAllNews()
    }
    
    func didSelected(article: NewsArticleDTO) {
        
    }
}

//MARK: - NewsListInteractorOutputProtocol
extension NewsListPresenter: NewsListInteractorOutputProtocol {
    func fetchDataSuccess(data: [NewsArticleDTO]) {//imagem, autor, titulo e descricao respectivamente
        articles = data
        
    }
    
    func fetchDataFailure(with message: String?) {
        view?.showError(with: message)
    }
}
