//
//  NewsListProtocols.swift
//  NewsApp
//
//  Created by João Paulo Pereira dos Santos on 20/05/24.
//

import UIKit

protocol NewsListInteractorInputProtocol: AnyObject {
    var presenter: NewsListInteractorOutputProtocol? { get set }
    var network: NewsListRequestProtocol? { get set }
    func fetchAllNews()
    func search(with text: String)
    func didSelected(article: NewsArticleDTO) //FIXME: verificar necessidade
}

protocol NewsListInteractorOutputProtocol: AnyObject {
    func fetchDataSuccess(data: [NewsArticleDTO])
    func fetchDataFailure(with message: String?)
}

protocol NewsListPresenterInputProtocol: AnyObject {
    var interactor: NewsListInteractorInputProtocol? { get set }
    var view: NewsListPresenterOutputProtocol? { get set }
    var router: NewsListRouterProtocol? { get set }
    func viewDidLoad()
    func didSelected(article: NewsArticleDTO)
}

protocol NewsListPresenterOutputProtocol: AnyObject {
    var presenter: NewsListPresenterInputProtocol? { get set }
    func setDataSource(news: [NewsArticleDTO])
    func setLoading(isLoading: Bool)
    func showError(with message: String?)
}

protocol NewsListRouterProtocol: AnyObject {
    func showModule() -> UIViewController
    func details(of article: NewsArticleDTO) // Imagem, data de publicacao e conteúdo respectivamente
}

protocol NewsListRequestProtocol: AnyObject {
    func fetchAllNews(completion: @escaping (NewsResponse?, Error?) -> Void)
    func search(with text: String, completion: @escaping (NewsResponse?, Error?) -> Void)
}
