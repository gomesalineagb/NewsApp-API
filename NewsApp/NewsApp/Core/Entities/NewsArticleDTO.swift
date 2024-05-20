//
//  NewsArticle.swift
//  NewsApp
//
//  Created by João Paulo Pereira dos Santos on 20/05/24.
//

import Foundation

struct NewsArticleDTO {
    var author: String?
    var title: String
    var description: String
    var urlToImage: URL?
    var publishedAt: Date
    var content: String
}
