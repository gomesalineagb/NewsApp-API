//
//  EverythingRequest.swift
//  NewsApp
//
//  Created by João Paulo Pereira dos Santos on 20/05/24.
//

import UIKit

public class NewsRequest {
    
    var interactor: NewsListInteractorInputProtocol?
    
    init(interactor: NewsListInteractorInputProtocol? = nil) {
        self.interactor = interactor
    }
}

// MARK: -NewsListRequestProtocol
extension NewsRequest: NewsListRequestProtocol {
    
    func fetchAllNews(completion: @escaping (NewsResponse?, Error?) -> Void) {
        let url = URL(string: NewsEndpoints.everything)
        
        if let url = url {
            var request = URLRequest(url: url)
            
            request.httpMethod = "GET"
            request.allHTTPHeaderFields = [
                "X-Api-Key" : "70a2d700e0c64527bd7a5b9285505111",
                "application/json" : "Content-Type"
            ]
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                
                if let data = data {
                    if let news = try? JSONDecoder().decode(NewsResponse.self, from: data) {
                        print(news)
                        completion(news, nil)
                        
                    } else {
                        print("Invalid Response")
                        completion(nil, error)
                    }
                } else if let error = error {
                    print("HTTP Request Failed \(error)")
                    completion(nil, error)
                }
            }
            task.resume()
        }
    }
    
    func search(with text: String, completion: @escaping (NewsResponse?, Error?) -> Void) {
        let url = URL(string: "\(NewsEndpoints.everything)?q=\(text)")
        
        if let url = url {
            var request = URLRequest(url: url)
            
            request.httpMethod = "GET"
            request.allHTTPHeaderFields = [
                "X-Api-Key" : "70a2d700e0c64527bd7a5b9285505111",
                "application/json" : "Content-Type"
            ]
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                
                if let data = data {
                    if let news = try? JSONDecoder().decode(NewsResponse.self, from: data) {
                        print(news)
                        completion(news, nil)
                        
                    } else {
                        print("Invalid Response")
                        completion(nil, error)
                    }
                } else if let error = error {
                    print("HTTP Request Failed \(error)")
                    completion(nil, error)
                }
            }
            task.resume()
        }
    }
}
