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
    
    private func getRequest(url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = [
            "X-Api-Key" : "70a2d700e0c64527bd7a5b9285505111"
        ]
        return request
    }
}

// MARK: -NewsListRequestProtocol
extension NewsRequest: NewsListRequestProtocol {
    
    func fetchAllNews(completion: @escaping (NewsResponse?, Error?) -> Void) {
        let url = URL(string: "\(NewsEndpoints.topHeadlines)?country=us")
        
        if let url = url {
            
            let request = getRequest(url: url)
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data {
                    do {
                        let news = try JSONDecoder().decode(NewsResponse.self, from: data)
                        print(news)
                        completion(news, nil)
                    } catch (let error) {
                        print(error)
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
            
            let request = getRequest(url: url)
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                
                if let data = data {
                    do {
                        let news = try JSONDecoder().decode(NewsResponse.self, from: data)
                        print(news)
                        completion(news, nil)
                    } catch (let error) {
                        print(error)
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
