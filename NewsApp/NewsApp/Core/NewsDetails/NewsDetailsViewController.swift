//
//  NewsDetailsViewController.swift
//  NewsApp
//
//  Created by João Paulo Pereira dos Santos on 21/05/24.
//

import UIKit

public class NewsDetailsViewController: UIViewController {
    
    internal var presenter: NewsDetailsPresenterInputProtocol?
    
    private var article: NewsArticleDTO?
    private var contentView = NewsDetailsContainerView()
    
    init(presenter: NewsDetailsPresenterInputProtocol? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.presenter = presenter
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        contentView.setupView()
        setupView()
        presenter?.viewDidLoad()
    }
}

// MARK: ViewCodeProtocol
extension NewsDetailsViewController: ViewCodeProtocol {
    func setupViewHierarchy() {
        view.addSubview(contentView)
    }
    
    func setupViewConstraints() {
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    func setupViewAditionalConfiguration() {
        view.backgroundColor = .white
    }
}

// MARK: - NewsDetailsPresenterOutputProtocol
extension NewsDetailsViewController: NewsDetailsPresenterOutputProtocol {
    func set(article: NewsArticleDTO) {
        contentView.setupView(with: .init(image: article.image,
                                          date: Date.getFormattedDate(string: article.publishedAt),
                                          content: article.content))
    }
}
