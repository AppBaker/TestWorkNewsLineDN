//
//  LoadingTableViewCell.swift
//  NewsLineDN
//
//  Created by Ivan Nikitin on 30.01.2020.
//  Copyright © 2020 Ivan Nikitin. All rights reserved.
//

import UIKit

class LoadingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var label: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
