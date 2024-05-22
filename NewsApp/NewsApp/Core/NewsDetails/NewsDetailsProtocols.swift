//
//  NewsDetailsProtocols.swift
//  NewsApp
//
//  Created by João Paulo Pereira dos Santos on 21/05/24.
//

import UIKit

protocol NewsDetailsPresenterInputProtocol: AnyObject {
    var view: NewsDetailsPresenterOutputProtocol? { get set }
    var router: NewsDetailsRouterProtocol? { get set }
    func viewDidLoad()
}

protocol NewsDetailsPresenterOutputProtocol: AnyObject {
    var presenter: NewsDetailsPresenterInputProtocol? { get set }
    func set(article: NewsArticleDTO)
}

protocol NewsDetailsRouterProtocol: AnyObject {
    func showModule(article: NewsArticleDTO) -> UIViewController
}
