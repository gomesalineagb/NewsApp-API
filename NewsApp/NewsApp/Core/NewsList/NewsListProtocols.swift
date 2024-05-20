//
//  NewsListProtocols.swift
//  NewsApp
//
//  Created by João Paulo Pereira dos Santos on 20/05/24.
//

import Foundation

protocol NewsListInteractorInputProtocol: AnyObject {
    func fetchAllNews()
    func search(with text: String)
    func didSelected(article: NewsArticleDTO) //FIXME: verificar necessidade
    
}

protocol NewsListInteractorOutputProtocol: AnyObject {
    func fetchDataSuccess(data: [NewsArticleDTO])
    func fetchDataFailure()
}

protocol NewsListPresenterInputProtocol: AnyObject {
    func viewDidLoad()
    func didSelected(article: NewsArticleDTO)
}

protocol NewsListPresenterOutputProtocol: AnyObject {
    func setDataSource(news: [NewsArticleDTO])
    func setLoading(isLoading: Bool)
}

protocol NewsListRouterProtocol: AnyObject {
    func details(of article: NewsArticleDTO) // Imagem, data de publicacao e conteúdo respectivamente
}
