//
//  NewsModel.swift
//  NewsLineDN
//
//  Created by Ivan Nikitin on 22.01.2020.
//  Copyright © 2020 Ivan Nikitin. All rights reserved.
//

import UIKit

struct Article {
    var title: String
    var description: String?
    var urlToImage: String?
    var publishedAt: String
    var url: String
    var image: UIImage?
    var isImageLoaded = false
}
