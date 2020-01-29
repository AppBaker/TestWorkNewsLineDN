//
//  TableViewCellViewModelType.swift
//  NewsLineDN
//
//  Created by Ivan Nikitin on 23.01.2020.
//  Copyright © 2020 Ivan Nikitin. All rights reserved.
//

import UIKit

protocol TableViewCellViewModelType: class {
    var title: String { get }
    var description: String { get }
    var date: String { get }
    var image: UIImage? { get }
    var urlToImage: String? { get }
    
    func setImage()
}
