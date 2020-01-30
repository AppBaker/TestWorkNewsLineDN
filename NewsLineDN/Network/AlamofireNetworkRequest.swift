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
                                              description: article["description"] as? String,
                                              urlToImage: article["urlToImage"] as? String,
                                              publishedAt: article["publishedAt"] as! String,
                                              url: article["url"] as! String,
                                              image: nil
                        )
                        articles.append(article)
                    }
                    completion(articles)
                }
                
            case .failure(let error):
                print("ERROR: ", error)
                completion([Article]())
            }
        }
    }
    
    static func loadImage(url: String?, completion: @escaping (_ articles: UIImage?)->()){
        
        guard let imageUrl = url else {
            print("######## IMAGE URL = NIL #######")
            completion(#imageLiteral(resourceName: "Error"))
            return
        }
        
        guard let url = URL(string: imageUrl) else {
            completion(#imageLiteral(resourceName: "Error"))
            print("######## NOT IMAGE URL #######")
            return
        }
        
        AF.request(url, method: .get).validate().response { (response) in
            
            switch response.result {
            case .success(let value):
                guard let imageData = value else {
                    print("######## NOT IMAGE DATA #######")
                    completion(#imageLiteral(resourceName: "Error"))
                    return
                }
                
                if let image = UIImage(data: imageData) {
                    print("########## GET IMAGE ########")
                    completion(image)
                } else {
                    print("######## NO IMAGE IN DATA #######")
                    completion(#imageLiteral(resourceName: "Error"))
                }
                
            case .failure(let error):
                print("######## LOAD IMAGE ERROR ########", error)
                completion(#imageLiteral(resourceName: "Error"))
                
            }
        }
    }
}

