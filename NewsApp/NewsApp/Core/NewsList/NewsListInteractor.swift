//
//  NewsListInteractor.swift
//  NewsApp
//
//  Created by João Paulo Pereira dos Santos on 20/05/24.
//

import Foundation

public class NewsListInteractor {
    private var presenter: NewsListInteractorOutputProtocol?
    
    init(presenter: NewsListInteractorOutputProtocol? = nil) {
        self.presenter = presenter
    }
}

// MARK: -
extension NewsListInteractor: NewsListInteractorInputProtocol {
    func fetchAllNews() {
        
    }
    
    func search(with text: String) {
        
    }
    
    func didSelected(article: NewsArticleDTO) {
        
    }
}
