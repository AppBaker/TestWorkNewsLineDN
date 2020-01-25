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
        navigationController?.isNavigationBarHidden = true
        createTable()
        view.backgroundColor = .white
        splashScreen()
        viewModel?.getListOfArticles()
        viewModel?.delegate = self
//        newsTableView.prefetchDataSource = self
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
        
        return tableViewCell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard let viewModel = viewModel else { return }
        
        print("%%%%%%%%%%%%% LAST LOADED INDEX = ", viewModel.lastLoadedImage)
//        if indexPath.row == viewModel.lastLoadedImage && viewModel.listOfArticles[viewModel.lastLoadedImage].isImageLoaded == true {
//            print("############    LOADING BANCH from \(viewModel.lastLoadedImage)")
//            viewModel.loadImagesForRange(count: 5)
//        }
        
        print("############ willDisplay cell at \(indexPath.row)")
        
//        if viewModel?.listOfArticles[indexPath.row].image == nil {
//
//        }
        
//        if viewModel?.listOfArticles[indexPath.row].image == nil {
//            viewModel?.loadImageFor(indexPath: indexPath)
//        }
    }
}

//MARK: - TableViewDelegate
extension NewsLineViewController:  UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        
        webView.newsTitle = viewModel?.listOfArticles[indexPath.row].title
        
        if let controllers = navigationController?.viewControllers {
            var newControllers = controllers
            newControllers.append(webView)
            navigationController?.setViewControllers(newControllers, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        print("############ \(indexPath.row) visible row")
        return nil
    }
    
    
 
}

//MARK: - UITableViewDataSourcePrefetching

//extension NewsLineViewController: UITableViewDataSourcePrefetching {
//    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
//        for indexPath in indexPaths {
//            viewModel?.loadImageFor(indexPath: indexPath)            
//        }
//    }
//}

//MARK: - Delegate Methods
extension NewsLineViewController: LoadDataDelegate {
    func loadTable() {
        self.newsTableView.reloadData()
    }
    
    
    
    func loadTableData() {
        DispatchQueue.main.async {
            self.navigationController?.isNavigationBarHidden = false
            UIView.animate(withDuration: 0.3, animations: {
                self.splashView.alpha = 0
            }) { (bool) in
                self.splashView.isHidden = true
            }
            self.newsTableView.reloadData()
        }
    }
    
    func updateImage(indexPath: IndexPath) {
        DispatchQueue.main.async {
            self.newsTableView.reloadRows(at: [indexPath], with: .automatic)
            print("########## UPDATIN IMAGE FOR IndexPath ---- ", indexPath)
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


