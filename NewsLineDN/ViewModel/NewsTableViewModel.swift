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
    func loadTableData()
    func loadTable()
    func updateImage(indexPath: IndexPath)
}

class NewsTableViewModel {
    
    var lastLoadedImage = 0
    let prefetchCount = 5
    var delegate: LoadDataDelegate?
    var listOfArticles = [Article]()
    
    
    
    let viewTitle = "News"
    private let url = "https://newsapi.org/v2/everything?q=android&from=2019-04-00&sortBy=publishedAt&apiKey=26eddb253e7840f988aec61f2ece2907&page=5"
    
    func getListOfArticles() {
        AlamofireNetworkRequest.loadNews(url: url) { (articles) in
            self.listOfArticles.append(contentsOf: articles)
            self.delegate?.loadTable()
            self.loadFirstBunchOfImages(count: self.prefetchCount)
        }
    }
    
    func loadFirstBunchOfImages(count: Int) {
        let lastIndex = lastLoadedImage + count
        print("$$$$$$$$$$$$$$$$$$", lastLoadedImage)
        for index in lastLoadedImage..<lastIndex {
            let indexPath = IndexPath(row: index, section: 0)
            if !listOfArticles[index].isImageLoaded {
                loadImageForIndex(indexPath: indexPath)
            }
        }
    }
    
    func loadImageForIndex(indexPath: IndexPath) {
        let url = listOfArticles[indexPath.row].urlToImage
            Network.loadImage(fromURL: url) { (image) in
                
                print("LOADED IMAGE FOR \(indexPath.row)")
        
                self.listOfArticles[indexPath.row].image = image
                self.listOfArticles[indexPath.row].isImageLoaded = true
                self.lastLoadedImage += 1
                self.delegate?.updateImage(indexPath: indexPath)
                
                if self.lastLoadedImage == self.prefetchCount {
                    self.delegate?.loadTableData()
                }
                
        }
    }
    
    func loadImagesForRange(count: Int){
        
        let lastIndex = lastLoadedImage + count
        for index in lastLoadedImage..<lastIndex {
            let indexPath = IndexPath(row: index, section: 0)
            loadImageForIndex(indexPath: indexPath)
        }
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> TableViewCellViewModelType? {
        let article = listOfArticles[indexPath.row]
        
        return TableViewCellViewModel(article: article)
    }
}

