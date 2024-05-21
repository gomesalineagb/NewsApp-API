//
//  NewsListInteractor.swift
//  NewsApp
//
//  Created by João Paulo Pereira dos Santos on 20/05/24.
//

import Foundation

public class NewsListInteractor {
    internal var presenter: NewsListInteractorOutputProtocol?
    internal var network: NewsListRequestProtocol?
    
    init(presenter: NewsListInteractorOutputProtocol? = nil, network: NewsListRequestProtocol? = nil) {
        self.presenter = presenter
        self.network = network
    }
}

// MARK: -
extension NewsListInteractor: NewsListInteractorInputProtocol {
    func fetchAllNews() {
        network?.fetchAllNews(completion: { [weak self] response, error in
            if let response = response {
                if response.status == .ok {
                    let articles = response.articles.map({ $0.toDTO()})
                    self?.presenter?.fetchDataSuccess(data: articles)
                } else {
                    self?.presenter?.fetchDataFailure(with: response.message)
                }
                
            } else if let error = error {
                self?.presenter?.fetchDataFailure(with: nil)
            }
        })
    }
    
    func search(with text: String) {
        network?.search(with: text, completion: { [weak self] response, error in
            if let response = response {
                if response.status == .ok {
                    let articles = response.articles.map({ $0.toDTO()})
                    self?.presenter?.fetchDataSuccess(data: articles)
                } else {
                    self?.presenter?.fetchDataFailure(with: response.message)
                }
                
            } else if let error = error {
                self?.presenter?.fetchDataFailure(with: nil)
            }
        })
    }
    
    func didSelected(article: NewsArticleDTO) {
        
    }
}
