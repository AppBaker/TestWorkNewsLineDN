//
//  NewsLineViewController.swift
//  NewsLineDN
//
//  Created by Ivan Nikitin on 22.01.2020.
//  Copyright © 2020 Ivan Nikitin. All rights reserved.
//

import UIKit

class NewsLineViewController: UIViewController {
    
    var viewModel: NewsTableViewModel?
    
    var splashView: UIView!
    let cellIdentifire = "NewsCell"
    let webView = WebViewController()
    
    var newsTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = NewsTableViewModel()
        title = viewModel?.viewTitle
        view.backgroundColor = .white
        navigationController?.isNavigationBarHidden = true
        
        createTable()
        splashScreen()
        
        viewModel?.loadPage()
        viewModel?.delegate = self
        
    }
    
    
}

//MARK: - TableViewDataSource
extension NewsLineViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.listOfArticles.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = newsTableView.dequeueReusableCell(withIdentifier: cellIdentifire, for: indexPath) as? NewsTableViewCell
        
        guard let tableViewCell = cell, let viewModel = viewModel else { return UITableViewCell()}
        
        let cellViewModel = viewModel.cellViewModel(forIndexPath: indexPath)
        tableViewCell.viewModel = cellViewModel
        
        if indexPath.row == viewModel.listOfArticles.count - viewModel.prefetchCount && viewModel.isListLoaded {
            viewModel.loadPage()
        }
        return tableViewCell
    }
}

//MARK: - TableViewDelegate
extension NewsLineViewController:  UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        
        webView.urlString = viewModel?.listOfArticles[indexPath.row].url
        
        if let controllers = navigationController?.viewControllers {
            var newControllers = controllers
            newControllers.append(webView)
            navigationController?.setViewControllers(newControllers, animated: true)
        }
    }
}

//MARK: - Delegate Methods
extension NewsLineViewController: LoadDataDelegate {
    func reloadTable() {
        DispatchQueue.main.async {
            self.newsTableView.reloadData()
        }
    }

    func firstLoadTableData() {
        guard let viewModel = viewModel else { return }
        DispatchQueue.main.async {
            
            self.navigationController?.isNavigationBarHidden = false
            UIView.animate(withDuration: 0.3, animations: {
                self.splashView.alpha = 0
            }) { (bool) in
                self.splashView.isHidden = true
            }
            
            self.newsTableView.reloadData()
            
            viewModel.tableViewIsLoaded = true
        }
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
    }
    
}


