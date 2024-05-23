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
    private var searchController = UISearchController(searchResultsController: nil)
    private var activityView: UIActivityIndicatorView = .init()
    private var articles: [NewsArticleDTO] = []
    
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
        tableView.tableFooterView = UIView()
        
        self.tableView = tableView
        
    }
    
    private func setupSearchBar() {
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = NewsListStrings.searchPlaceholder
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        
        navigationItem.searchController = searchController
        definesPresentationContext = false
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func setupActivityView() {
        activityView = UIActivityIndicatorView(frame: .zero)
        activityView.hidesWhenStopped = true
        activityView.style = .large
        activityView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func showLoading() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.isHidden = true
            self?.activityView.startAnimating()
        }
    }
    
    private func stopLoading() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.isHidden = false
            self?.activityView.stopAnimating()
        }
    }
    
}

// MARK: ViewCodeProtocol
extension NewsListViewController: ViewCodeProtocol {
    func setupViewHierarchy() {
        setupActivityView()
        setupTableView()
        setupSearchBar()
        view.addSubview(tableView)
        view.addSubview(activityView)
        
    }
    
    func setupViewConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            activityView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
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
        articles[index - 1].image = image
        tableView.beginUpdates()
        tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
        tableView.endUpdates()
    }
}

// MARK: - UITableViewDataSource
extension NewsListViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        !articles.isEmpty ? articles.count : 1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ArticleTableViewCell.self),
                                                       for: indexPath) as? ArticleTableViewCell,
              !articles.isEmpty else {
            
            let cell = UITableViewCell()
            var content = cell.defaultContentConfiguration()
            content.text = NewsListStrings.emptyList
            cell.contentConfiguration = content
            return cell
        }
        let article = articles[indexPath.item]
        cell.setupCell(with: .init(image: article.image,
                                   author: article.author,
                                   title: article.title,
                                   content: article.description))
        return cell
    }
}

// MARK: - UITableViewDelegate
extension NewsListViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelected(index: indexPath.row)
    }
}

// MARK: - UISearchBarDelegate
extension NewsListViewController: UISearchBarDelegate {
    public func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if let text = searchBar.text, !text.isEmpty {
            presenter?.search(with: text)
        }
    }
}
