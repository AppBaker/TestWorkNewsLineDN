//
//  NewsLineViewController.swift
//  NewsLineDN
//
//  Created by Ivan Nikitin on 22.01.2020.
//  Copyright © 2020 Ivan Nikitin. All rights reserved.
//

import UIKit

class NewsLineViewController: UIViewController {
    
    var splashView: UIView!
    let names = ["Ivan", "Petr", "David"]
    let cellIdentifire = "NewsCell"
    let webView = WebViewController()

    var newsTableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "News"
        
        createTable()
        view.backgroundColor = .white
        splashScreen()
    }
    

}

//MARK: - TableViewDataSource
extension NewsLineViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = newsTableView.dequeueReusableCell(withIdentifier: cellIdentifire, for: indexPath) as! NewsTableViewCell
        cell.title.text = names[indexPath.row]
        return cell
    }
}

//MARK: - TableViewDelegate
extension NewsLineViewController:  UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        
        webView.newsTitle = names[indexPath.row]
        
        if let controllers = navigationController?.viewControllers {
            var newControllers = controllers
            newControllers.append(webView)
            navigationController?.setViewControllers(newControllers, animated: true)
        }
        print(navigationController?.viewControllers)
        
        
//        navigationController?.present(webView, animated: true, completion: nil)
//        navigationController?.popToViewController(webView, animated: true)
//        self.present(vc, animated: true, completion: nil)
    }
    
    
}


//MARK: - Custom methods
extension NewsLineViewController {
    
    func createTable() {
        newsTableView = UITableView(frame: view.bounds, style: .plain)
        newsTableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifire)
        
        newsTableView.delegate = self
        newsTableView.dataSource = self
        
        newsTableView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        view.addSubview(newsTableView)
    }
    
    func splashScreen() {
        
        splashView = UIView(frame: view.bounds)
        splashView.backgroundColor = .white
        let image = UIImageView(image: #imageLiteral(resourceName: "cat"))
        image.frame = splashView.bounds
        image.contentMode = .scaleAspectFit
        splashView.addSubview(image)
        view.addSubview(splashView)
        
        Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { (timer) in
            print("TIMER OK")
            UIView.animate(withDuration: 0.3, animations: {
                self.splashView.alpha = 0
            }) { (bool) in
                self.splashView.isHidden = true
            }
            
        }
//        timer.fire()
    }
    
}


