//
//  APICaller.swift
//  NewsSwiftExample
//
//  Created by SanaAsif on 05/07/2021.
//

import Foundation

final class APICaller {
    static let shared = APICaller()
    
    struct Constants {
        static let topHeadlinesURL = URL(string: "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=56ecc62728f3431e962ce79b7c0be505")
    }
    
    private init(){
        
    }
    
    public func getTopStories(completion: @escaping (Result<[Article], Error>) -> Void){
        guard let url = Constants.topHeadlinesURL else {
            return
        }
        
       
        
        let task = URLSession.shared.dataTask(with: url) { data, response,  error in
            if let error = error {
                completion(.failure(error))
            }
            
            else if let data = data {
                
                do {
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)
                    print("Articles: \(result.articles.count)")
                    completion(.success(result.articles))
                }
                catch {
                    completion(.failure(error))
                }
            }
            
        }
        
        task.resume()
            
        
    }
}

//Models

struct APIResponse: Codable {
    let articles : [Article]
}

struct Article: Codable{
    let source: Source
    let title: String
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String
}

struct Source: Codable{
    let name: String
}
