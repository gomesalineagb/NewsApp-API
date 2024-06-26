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
    func downloadImage(for url: String?, index: Int)
}

protocol NewsListInteractorOutputProtocol: AnyObject {
    func fetchDataSuccess(data: [NewsArticleDTO])
    func fetchDataFailure(with message: String?)
    func updateImage(for index: Int, image: UIImage?)
}

protocol NewsListPresenterInputProtocol: AnyObject {
    var interactor: NewsListInteractorInputProtocol? { get set }
    var view: NewsListPresenterOutputProtocol? { get set }
    var router: NewsListRouterProtocol? { get set }
    func viewDidLoad()
    func didSelected(index: Int)
    func downloadImage(for url: String?, index: Int)
    func search(with text: String)
}

protocol NewsListPresenterOutputProtocol: AnyObject {
    var presenter: NewsListPresenterInputProtocol? { get set }
    func setDataSource(articles: [NewsArticleDTO])
    func setLoading(isLoading: Bool)
    func showError(with message: String?)
    func updateImage(for index: Int, image: UIImage?)
}

protocol NewsListRouterProtocol: AnyObject {
    func showModule() -> UIViewController
    func details(of article: NewsArticleDTO)
}

protocol NewsListRequestProtocol: AnyObject {
    func fetchAllNews(completion: @escaping (NewsResponse?, Error?) -> Void)
    func search(with text: String, completion: @escaping (NewsResponse?, Error?) -> Void)
}
