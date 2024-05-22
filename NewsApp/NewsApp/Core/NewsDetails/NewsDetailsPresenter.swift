//
//  NesDetailsPresenter.swift
//  NewsApp
//
//  Created by João Paulo Pereira dos Santos on 21/05/24.
//

import Foundation

public class NewsDetailsPresenter {
    private var article: NewsArticleDTO
    weak var view: NewsDetailsPresenterOutputProtocol?
    var router: NewsDetailsRouterProtocol?
    
    init(article: NewsArticleDTO) {
        self.article = article
    }
}

//MARK:  - NewsDetailsPresenterInputProtocol
extension NewsDetailsPresenter: NewsDetailsPresenterInputProtocol {
    
    func viewDidLoad() {
        view?.set(article: article)
    }
}
