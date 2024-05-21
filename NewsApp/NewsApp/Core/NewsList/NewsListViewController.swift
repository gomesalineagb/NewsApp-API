//
//  NewsListViewController.swift
//  NewsApp
//
//  Created by João Paulo Pereira dos Santos on 20/05/24.
//

import UIKit

public class NewsListViewController: UIViewController {
    
    internal var presenter: NewsListPresenterInputProtocol?
    
    private var tableView: UITableView = UITableView()
    private var activityView: UIActivityIndicatorView = .init()
    private var articles: [NewsArticleDTO]?
    
    init(presenter: NewsListPresenterInputProtocol? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.presenter = presenter
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        setupView()
    }
    
    private func setupTableView() {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ArticleTableViewCell.self, forCellReuseIdentifier: String(describing: ArticleTableViewCell.self))
        tableView.backgroundView = activityView
        tableView.tableFooterView = UIView()
        
        self.tableView = tableView
        
    }
    
    private func setupActivityView() {
        activityView = UIActivityIndicatorView(style: .large)
        activityView.center = self.view.center
    }
    
    private func showLoading() {
        DispatchQueue.main.async { [weak self] in
            self?.activityView.startAnimating()
        }
    }
    
    private func stopLoading() {
        DispatchQueue.main.async { [weak self] in
            self?.activityView.stopAnimating()
        }
    }
    
}

// MARK: ViewCodeProtocol
extension NewsListViewController: ViewCodeProtocol {
    func setupViewHierarchy() {
        setupTableView()
        setupActivityView()
        view.addSubview(activityView)
        view.addSubview(tableView)
        
    }
    
    func setupViewConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    func setupViewAditionalConfiguration() {
        view.backgroundColor = .white
    }
    
}

// MARK: - NewsListPresenterOutputProtocol
extension NewsListViewController: NewsListPresenterOutputProtocol {
    func setDataSource(articles: [NewsArticleDTO]) {
        self.articles = articles
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    func setLoading(isLoading: Bool) {
        if isLoading {
            showLoading()
        } else {
            stopLoading()
        }
    }
    
    func showError(with message: String?) {
        let alert = UIAlertController(title: NewsListStrings.errorTitle, message: NewsListStrings.errorDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    func updateImage(for index: Int, image: UIImage?) {
        articles?[index - 1].image = image
        tableView.beginUpdates()
        tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
        tableView.endUpdates()
    }
}

// MARK: - UITableViewDataSource
extension NewsListViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        articles?.count ?? 0
    }
}

// MARK: - UITableViewDelegate
extension NewsListViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing:ArticleTableViewCell.self), for: indexPath) as? ArticleTableViewCell, let article = articles?[indexPath.item] else {
            return UITableViewCell()
        }
        cell.setupCell(with: .init(image: article.image,
                                   author: article.author,
                                   title: article.title,
                                   content: article.content))
        
        return cell
    }
}
