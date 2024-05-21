//
//  NewsListInteractor.swift
//  NewsApp
//
//  Created by João Paulo Pereira dos Santos on 20/05/24.
//

import UIKit

public class NewsListInteractor {
    internal var presenter: NewsListInteractorOutputProtocol?
    internal var network: NewsListRequestProtocol?
    private var articles: [NewsArticleDTO] = []
    
    init(presenter: NewsListInteractorOutputProtocol? = nil, network: NewsListRequestProtocol? = nil) {
        self.presenter = presenter
        self.network = network
    }
    
    private func parseToDTO(articles: [NewsResponseArticles]) -> [NewsArticleDTO] {
        return articles.compactMap { article in
            if article.title == "[Removed]" {
                return nil
            }
            return NewsArticleDTO(author: article.author,
                                  title: article.title ?? "",
                                  description: article.description ?? "",
                                  urlToImage: article.urlToImage,
                                  publishedAt: article.publishedAt ?? "",
                                  content: article.content ?? "")
            
        }
    }
}

// MARK: -
extension NewsListInteractor: NewsListInteractorInputProtocol {
    func fetchAllNews() {
        network?.fetchAllNews(completion: { [weak self] response, error in
            if let response = response, let articles = response.articles {
                if response.status == .ok {
                    if let articles = self?.parseToDTO(articles: articles) {
                        self?.presenter?.fetchDataSuccess(data: articles)
                    }
                    
                } else {
                    self?.presenter?.fetchDataFailure(with: response.message)
                }
                
            } else if let _ = error {
                self?.presenter?.fetchDataFailure(with: nil)
            }
        })
    }
    
    func search(with text: String) {
        network?.search(with: text, completion: { [weak self] response, error in
            if let response = response {
//                if response.status == .ok {
//                    if let articles = response.articles?.map({ $0.toDTO()}){
//                        
////                        self?.presenter?.fetchDataSuccess(data: articles)
//                    }
//                } else {
//                    self?.presenter?.fetchDataFailure(with: response.message)
//                }
                
            } else if let _ = error {
                self?.presenter?.fetchDataFailure(with: nil)
            }
        })
    }
    
    func didSelected(article: NewsArticleDTO) {
        
    }
    
    func downloadImage(for url: String?, index: Int) {
        
        let url = URL(string: url ?? "")
        
        DispatchQueue.global().async {
            if let url = url, let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async { [weak self] in
                    self?.presenter?.updateImage(for: index, image: UIImage(data: data))
                }
            }
        }
        
    }
}
