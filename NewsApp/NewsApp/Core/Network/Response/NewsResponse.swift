//
//  EverythingResponse.swift
//  NewsApp
//
//  Created by João Paulo Pereira dos Santos on 20/05/24.
//

import Foundation

struct NewsResponse: Decodable {
    var status: NewsStatusResponse
    var totalResults: Int
    var articles: [NewsResponseArticles]
}
