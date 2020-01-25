//
//  Network.swift
//  NewsLineDN
//
//  Created by Ivan Nikitin on 23.01.2020.
//  Copyright © 2020 Ivan Nikitin. All rights reserved.
//

import UIKit

struct Network {
    static func loadImage(fromURL url: String?, completion: @escaping (_ image: UIImage?)->()) {
        
        guard let urlString = url else {
            completion(UIImage(named: "Error"))
            return
            
        }
        guard let url = URL(string: urlString) else {
            print("ERROR URL IMAGE")
            completion(UIImage(named: "Error"))
            return
        }
        
        let session = URLSession.shared
        
        session.dataTask(with: url) { (data, response, error) in
            
            if let loadError = error {
                print("ERROR LOADING IMAGE", loadError)
                completion(UIImage(named: "Error"))
                completion(UIImage(named: "Error"))
                return
            }
            
            if let data = data, let image = UIImage(data: data) {
                completion(image)
            }
        }.resume()
        
    }
}
