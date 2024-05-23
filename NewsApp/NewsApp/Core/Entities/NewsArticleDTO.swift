//
//  NewsArticle.swift
//  NewsApp
//
//  Created by João Paulo Pereira dos Santos on 20/05/24.
//

import UIKit

struct NewsArticleDTO {
    var author: String?
    var title: String
    var description: String
    var urlToImage: String?
    var image: UIImage?
    var publishedAt: String
    var content: String
}

extension NewsArticleDTO: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.author == rhs.author &&
        lhs.title == rhs.title &&
        lhs.description == rhs.description &&
        lhs.urlToImage == rhs.urlToImage &&
        lhs.image == rhs.image &&
        lhs.publishedAt == rhs.publishedAt &&
        lhs.content == rhs.content
    }
}
