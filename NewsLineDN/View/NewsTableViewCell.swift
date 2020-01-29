//
//  NewsTableViewCell.swift
//  NewsLineDN
//
//  Created by Ivan Nikitin on 22.01.2020.
//  Copyright © 2020 Ivan Nikitin. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var postDate: UILabel!
    @IBOutlet weak var newsDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    weak var viewModel: TableViewCellViewModelType? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            title.text = viewModel.title
            if let image = viewModel.image {
                newsImageView.image = image
            } else {
                newsImageView.image = #imageLiteral(resourceName: "loading")
            }
            
            newsDescription.text = viewModel.description
            
            
            postDate.text = dateFromString(fromString: viewModel.date)
        }
    }
    
    func dateFromString(fromString: String) -> String {
                let dateFormater = DateFormatter()
                dateFormater.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                
                let date = dateFormater.date(from: fromString)
                if let date = date {
                    let myDateFormater = DateFormatter()
                    myDateFormater.dateFormat = "dd/MM/YYYY"
                return myDateFormater.string(from: date)
                } else {
                    return "no date"
        }
    }
}
