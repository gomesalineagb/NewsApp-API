//
//  EverythingResponseArticles.swift
//  NewsApp
//
//  Created by João Paulo Pereira dos Santos on 20/05/24.
//

import UIKit

struct NewsResponseArticles: Decodable {
    var source: NewsResponseSource
    var author: String?
    var title: String?
    var description: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
    var content: String?
}
