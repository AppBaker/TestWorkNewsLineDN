//
//  NewsTableViewModel.swift
//  NewsLineDN
//
//  Created by Ivan Nikitin on 22.01.2020.
//  Copyright © 2020 Ivan Nikitin. All rights reserved.
//

import Foundation
import Alamofire

protocol LoadDataDelegate {
    
    func firstLoadTableData()
    func reloadTable()
}

class NewsTableViewModel {
    
    var firestLoad = false
    var tableViewIsLoaded = false
    var isListLoaded = false
    
    var currentPage = 1
    let pages = 5
    let prefetchCount = 5
    var firstListNewsCount = 0
    
    var delegate: LoadDataDelegate?
    var listOfArticles = [Article]()
    
    
    
    let viewTitle = "News"
    private let url = "http://newsapi.org/v2/everything?q=android&from=2019-04-00&sortBy=publishedAt&apiKey=bfa2ee84523d4d9889e397b2fd6c141c&page="
    
    func getUrl(page: Int) -> String {
        return url + "\(page)"
    }
    
    func loadPage() {
        isListLoaded = false
        if currentPage <= pages {
            AlamofireNetworkRequest.loadNews(url: getUrl(page: currentPage)) { (articles) in
                if articles.count > 0 {
                    self.currentPage += 1
                }
                print(self.currentPage)
                self.firstListNewsCount = articles.count
                let startIndex = self.listOfArticles.count
                self.listOfArticles.append(contentsOf: articles)
                
                for index in startIndex..<self.listOfArticles.count {
                    
                    AlamofireNetworkRequest.loadImage(url: self.listOfArticles[index].urlToImage) { (image) in
                        self.listOfArticles[index].image = image
                        self.listOfArticles[index].isImageLoaded = true
                        
                        if !self.firestLoad {
                            self.delegate?.firstLoadTableData()
                        }
                    }
                }
                
                if !self.firestLoad {
                    self.delegate?.firstLoadTableData()
                } else {
                    self.delegate?.reloadTable()
                }
                self.isListLoaded = true
            }
        }
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> TableViewCellViewModelType? {
        let article = listOfArticles[indexPath.row]
        
        return TableViewCellViewModel(article: article)
    }
}

