//
//  NewsListViewController.swift
//  NewsApp
//
//  Created by João Paulo Pereira dos Santos on 20/05/24.
//

import UIKit

public class NewsListViewController: UIViewController {
    
    internal var presenter: NewsListPresenterInputProtocol?
    
    init(presenter: NewsListPresenterInputProtocol? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.presenter = presenter
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: -
extension NewsListViewController: NewsListPresenterOutputProtocol {
    func setDataSource(news: [NewsArticleDTO]) {
        
    }
    
    func setLoading(isLoading: Bool) {
        //adiciona um componente de carregando na tela ()
    }
    
    func showError(with message: String?) {
        //chama uma view com uma label e um botao de tentar novamente.
    }
}
