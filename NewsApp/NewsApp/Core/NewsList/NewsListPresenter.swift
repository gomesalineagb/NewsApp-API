//
//  NewsListPresenter.swift
//  NewsApp
//
//  Created by João Paulo Pereira dos Santos on 20/05/24.
//

import UIKit

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
        view?.setDataSource(articles: [])
        interactor?.fetchAllNews()
    }
    
    func didSelected(index: Int) {
        
    }
    
    func downloadImage(for url: String?, index: Int) {
        interactor?.downloadImage(for: url, index: index)
    }
}

//MARK: - NewsListInteractorOutputProtocol
extension NewsListPresenter: NewsListInteractorOutputProtocol {
    func fetchDataSuccess(data: [NewsArticleDTO]) {
        articles = data
        var index = 0
        articles.forEach { article in
            index += 1
            interactor?.downloadImage(for: article.urlToImage, index: index)
        }
        view?.setDataSource(articles: data)
        view?.setLoading(isLoading: false)
    }
    
    func fetchDataFailure(with message: String?) {
        view?.showError(with: message)
        view?.setLoading(isLoading: false)
    }
    
    func updateImage(for index: Int, image: UIImage?) {
        view?.updateImage(for: index, image: image)
    }
}
