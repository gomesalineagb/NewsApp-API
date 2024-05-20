//
//  EverythingResponseArticles.swift
//  NewsApp
//
//  Created by João Paulo Pereira dos Santos on 20/05/24.
//

import Foundation

struct NewsResponseArticles: Decodable {
    var source: NewsResponseSource
    var author: String?
    var title: String
    var description: String
    var url: URL?
    var urlToImage: URL?
    var publishedAt: Date
    var content: String
    
    func toDTO() -> NewsArticleDTO {
        .init(author: self.author,
              title: self.title,
              description: self.description,
              urlToImage: self.urlToImage,
              publishedAt: self.publishedAt,
              content: self.content)
    }
}
