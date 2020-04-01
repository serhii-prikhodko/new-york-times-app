//
//  NetworkService.swift
//  new-york-times-app
//
//  Created by Serhiy Prikhodko on 3/31/20.
//  Copyright © 2020 Serhiy Prikhodko. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

enum MostParameter {
    case emailed, shared, viewed
}

class NetworkService {
    static var BASE_API_URL = "https://api.nytimes.com/svc/mostpopular/v2/"
    static var API_KEY = "WNd68fzGSGINN4dldANxWvQ3fiL3X5YY"
    static var PERIOD = "30"
    
    static func fetchArticles(completion: @escaping (ArticleList?, Error?)-> Void) {
        let tempURL = URL(string: "https://api.nytimes.com/svc/mostpopular/v2/\(MostParameter.viewed)/\(PERIOD).json")!
        let query: [String: String] = [
            "api-key": self.API_KEY
        ]
        let url = tempURL.withQueries(query)!
        AF.request(url).response { response in
            let data = response.data
            let error = response.error
            let jsonDecoder = JSONDecoder()
            if let data = data {
                do {
                    let articles = try jsonDecoder.decode(ArticleList.self, from: data)
                    completion(articles, nil)
                    
                } catch let error as NSError {
                    completion(nil, error)
                }
            } else {
                completion(nil, error)
            }
        }
    }
    
    static func fetchArticleImage(article: Article, completionHandler: @escaping (_ data: Data?) -> () ) {
        if let url = URL(string: self.getImageUrlFromArticle(article: article) ?? "") {
            AF.request(url).response { response in
                let data = response.data
                if let data = data {
                    completionHandler(data)
                } else {
                    completionHandler(nil)
                }
            }
        }
    }
    
    static func getImageUrlFromArticle(article: Article) -> String? {
        var urlString: String? = nil
        if let media = article.media {
            if media.isEmpty == false {
                if let mediaMetaData = media[0].mediaMetadata {
                    if let url = mediaMetaData[0].url {
                        urlString = url
                        
                        return urlString
                    }
                }
            }
        }
        
        return urlString
    }
}
extension URL {
    //Creates ULR, adding params queries to him
    func withQueries(_ queries: [String: String])-> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = queries.compactMap { URLQueryItem(name: $0.0, value: $0.1) }
        return components?.url
    }
}
