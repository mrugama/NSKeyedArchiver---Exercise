//
//  ImagesViewController.swift
//  NSKeyedArchiver - Exercise
//
//  Created by C4Q on 12/12/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit

class ImagesViewController: UIViewController {
    
    
    @IBOutlet weak var imageTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    private let refreshControl = UIRefreshControl()
    
    var images = [Image](){
        didSet {
            imageTableView.reloadData()
        }
    }
    var searchTerm = "" {
        didSet {
            loadImagesData(from: self.searchTerm.lowercased())
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageTableView.dataSource = self
        self.imageTableView.delegate = self
        self.searchBar.delegate = self
        self.refreshControl.addTarget(self, action: #selector(refreshOrders(_:)), for: UIControlEvents.valueChanged)
        self.imageTableView.refreshControl = refreshControl
        DataModel.shared.load()
    }
    
    @objc private func refreshOrders(_ sender: Any) {
        loadImagesData(from: self.searchTerm)
    }
    
    func loadImagesData(from str: String) {
        let setImagesToOnlineOrders = {(onlineImages: [Image]) in
            self.images = onlineImages
            self.imageTableView.reloadData()
            self.refreshControl.endRefreshing()
        }
        let printErrors = {(error: Error) in
            print(error)
        }
        ImageAPIClient.manager.getImages(from: str,completionHandler: setImagesToOnlineOrders, errorHandler: printErrors)
    }
    
    
    //MARK: Segue to AddFavoriteViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let addNav = segue.destination as? UINavigationController {
            if let AddFavVC = addNav.viewControllers.first as? AddFavoriteViewController {
                AddFavVC.favoriteImage = images[self.imageTableView.indexPathForSelectedRow!.row]
                print(AddFavVC.favoriteImage!.tags)
            }
        }
    }
}


