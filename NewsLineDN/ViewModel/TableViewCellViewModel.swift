//
//  TableViewCellViewModel.swift
//  NewsLineDN
//
//  Created by Ivan Nikitin on 23.01.2020.
//  Copyright © 2020 Ivan Nikitin. All rights reserved.
//

import UIKit

class TableViewCellViewModel: TableViewCellViewModelType {
    
    var image: UIImage? {
        return article.image
    }
    
    func setImage() {
        print("Image")
    }
    
    var urlToImage: String? {
        return article.urlToImage
    }
    

    private var article: Article

    var title: String {
        return article.title
    }
    
    var description: String {
        return article.description ?? "No description"
    }
    
    var date: String {
        return article.publishedAt
    }
    
    init(article: Article) {
        self.article = article
    }
}
