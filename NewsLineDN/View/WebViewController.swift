//
//  WebViewController.swift
//  NewsLineDN
//
//  Created by Ivan Nikitin on 22.01.2020.
//  Copyright © 2020 Ivan Nikitin. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {
    
    var newsTitle: String?

    @IBOutlet weak var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let newsTitle = newsTitle {
            title = newsTitle
            label.text = newsTitle
        }
    }
}
