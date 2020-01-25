//
//  AlamofireNetworkRequest.swift
//  NewsLineDN
//
//  Created by Ivan Nikitin on 22.01.2020.
//  Copyright © 2020 Ivan Nikitin. All rights reserved.
//

import Foundation
import Alamofire

struct AlamofireNetworkRequest {
    
    static func loadNews(url: String, completion: @escaping (_ articles: [Article])->()){
        
        guard let url = URL(string: url) else { return }
        
        AF.request(url, method: .get).validate().responseJSON { (response) in
            
            switch response.result {
            case .success(let value):
                guard let arrayOfItems = value as? [String : Any] else { return }
                
                var articles = [Article]()
                
                if let listOfArticles = arrayOfItems["articles"] as? Array<[String: Any]> {
                    for article in listOfArticles {
                        let article = Article(title: article["title"] as! String,
                                              description: article["description"] as! String,
                                              urlToImage: article["urlToImage"] as? String,
                                              publishedAt: article["publishedAt"] as! String,
                                              url: article["url"] as! String
                                              )
                        articles.append(article)
                    }
                    completion(articles)
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
}

